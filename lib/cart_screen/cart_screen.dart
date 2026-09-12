import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  double _parsePrice(String priceStr) {
    final cleaned = priceStr.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(cleaned) ?? 0.0;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // إذا لم يقم بالمستخدم بتسجيل الدخول
    if (user == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('My Cart')),
        body: const Center(child: Text('Please login to view your cart')),
      );
    }

    // Reference الخاص بسلة المستخدم الحالي فقط
    final userCartCollection = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('cart');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: (ModalRoute.of(context)?.canPop ?? false)
            ? IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        )
            : null,
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: userCartCollection.snapshots(), // يجلب فقط سلة هذا المستخدم
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Your Cart is Empty'));
          }

          final docs = snapshot.data!.docs;

          // حساب الإجمالي
          double subTotal = 0.0;
          for (var doc in docs) {
            final data = doc.data() as Map<String, dynamic>;
            final price = _parsePrice(data['price'] ?? '0');
            final qty = (data['quantity'] ?? 1) as int;
            subTotal += price * qty;
          }
          const double shippingFee = 80.0;
          const double vat = 0.0;
          final double total = subTotal + shippingFee + vat;

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final int quantity = data['quantity'] ?? 1;

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Colors.grey.shade200),
                      ),
                      child: Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              data['imagePath'] ?? '',
                              width: 70,
                              height: 70,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                width: 70,
                                height: 70,
                                color: Colors.grey.shade200,
                                child: const Icon(Icons.image, color: Colors.grey),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      data['title'] ?? '',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                    GestureDetector(
                                      onTap: () => userCartCollection.doc(doc.id).delete(),
                                      child: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 20),
                                    ),
                                  ],
                                ),
                                if (data['size'] != null && data['size'].toString().isNotEmpty)
                                  Text(
                                    'Size ${data['size']}',
                                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                                  ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${data['price']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                    ),
                                    Row(
                                      children: [
                                        _buildQtyBtn(
                                          icon: Icons.remove,
                                          onTap: () {
                                            if (quantity > 1) {
                                              userCartCollection.doc(doc.id).update({'quantity': quantity - 1});
                                            } else {
                                              userCartCollection.doc(doc.id).delete();
                                            }
                                          },
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Text('$quantity', style: const TextStyle(fontWeight: FontWeight.bold)),
                                        ),
                                        _buildQtyBtn(
                                          icon: Icons.add,
                                          onTap: () {
                                            userCartCollection.doc(doc.id).update({'quantity': quantity + 1});
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              // ملخص الأسعار
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildRowDetail('Sub-total', '\$ ${subTotal.toStringAsFixed(0)}'),
                    const SizedBox(height: 8),
                    _buildRowDetail('VAT (%)', '\$ ${vat.toStringAsFixed(2)}'),
                    const SizedBox(height: 8),
                    _buildRowDetail('Shipping fee', '\$ ${shippingFee.toStringAsFixed(0)}'),
                    const Divider(height: 24),
                    _buildRowDetail('Total', '\$ ${total.toStringAsFixed(0)}', isTotal: true),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff3B62CC),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text('Go To Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(width: 8),
                            Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQtyBtn({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Icon(icon, size: 14, color: Colors.black87),
      ),
    );
  }

  Widget _buildRowDetail(String title, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
            color: isTotal ? Colors.black : Colors.grey,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
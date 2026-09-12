import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:retailstoreapp/cart_screen/cart_screen.dart';


class DetailsScreen extends StatefulWidget {
  final String title;
  final String price;
  final String imagePath;
  final List<String>? sizes;

  const DetailsScreen({
    super.key,
    required this.title,
    required this.price,
    required this.imagePath,
    this.sizes,
  });

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String? selectedSize;

  @override
  void initState() {
    super.initState();
    if (widget.sizes != null && widget.sizes!.isNotEmpty) {
      selectedSize = widget.sizes!.first;
    }
  }

  //  دالة إضافة المنتج إلى Cart الخاص بالمستخدم الحالي
  Future<void> _addToCart() async {
    final user = FirebaseAuth.instance.currentUser;

    // التأكد من أن المستخدم مسجّل دخول
    if (user == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please login first!')),
        );
      }
      return;
    }

    try {
      // المسار الخاص بسلة المستخدم الحالي فقط
      final userCartRef = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('cart');

      // البحث هل المنتج موجود بالمقاس المحدد في سلة هذا المستخدم
      final query = await userCartRef
          .where('title', isEqualTo: widget.title)
          .where('size', isEqualTo: selectedSize ?? '')
          .get();

      if (query.docs.isNotEmpty) {
        // زيادة الكمية إذا كان موجوداً
        final docId = query.docs.first.id;
        final currentQty = query.docs.first['quantity'] as int;
        await userCartRef.doc(docId).update({'quantity': currentQty + 1});
      } else {
        // إضافة المنتج
        await userCartRef.add({
          'title': widget.title,
          'price': widget.price,
          'imagePath': widget.imagePath,
          'size': selectedSize ?? '',
          'quantity': 1,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Added to Cart!'),
            duration: Duration(seconds: 1),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  bool isFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. الصورة والأزرار العلوية
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
                    child: Image.asset(
                      widget.imagePath,
                      height: 320,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 320,
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.image, size: 80, color: Colors.grey),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    left: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 16,
                    right: 16,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.red : Colors.grey,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. الاسم والسعر
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      widget.price,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff5C5AD0),
                      ),
                    ),
                  ],
                ),
              ),

              // 3. التقييم
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  children: const [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 4),
                    Text('4.5 (20 Review)', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ],
                ),
              ),

              // 4. الوصف
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text('Description', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Culpa aliquam consequuntur veritatis at consequuntur praesentium beatae temporibus nobis. Velit dolorem facilis neque autem.',
                  style: TextStyle(color: Colors.grey, height: 1.4),
                ),
              ),
              const SizedBox(height: 20),

              // 5. قسم المقاسات (إن وجدت)
              if (widget.sizes != null && widget.sizes!.isNotEmpty) ...[
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Text('Size', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: widget.sizes!.map((size) {
                      final bool isSelected = selectedSize == size;
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedSize = size;
                          });
                        },
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.only(right: 12),
                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xff5C5AD0) : Colors.transparent,
                            border: Border.all(
                              color: isSelected ? const Color(0xff5C5AD0) : Colors.grey.shade300,
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            size,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 20),
              ],

              // 6. الجزء السفلي (أزرار الشراء والسلة)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 54,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff5C5AD0),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          ),
                          onPressed: () async {
                            await _addToCart();
                            if (context.mounted) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CartScreen()),
                              );
                            }
                          },
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      height: 54,
                      width: 54,
                      decoration: BoxDecoration(color: Colors.grey.shade100, shape: BoxShape.circle),
                      child: IconButton(
                        icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black87, size: 22),
                        onPressed: _addToCart,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
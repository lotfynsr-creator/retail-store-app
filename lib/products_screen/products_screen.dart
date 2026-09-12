import 'package:flutter/material.dart';
import 'package:retailstoreapp/details_screen/details_screen.dart';

class ProductsScreen extends StatelessWidget {
  final String categoryTitle;

  const ProductsScreen({
    super.key,
    this.categoryTitle = 'Products',
  });

  @override
  Widget build(BuildContext context) {
    // قائمة المنتجات الشاملة
    final List<Map<String, dynamic>> products = [
      {
        'title': 'Watch',
        'price': r'$40',
        'image': 'assets/images/watch.png',
        'sizes': ['38mm', '40mm', '42mm', '44mm'],
      },
      {
        'title': 'Nike Shoes',
        'price': r'$430',
        'image': 'assets/images/shoes.png',
        'sizes': ['38', '40', '42', '43'],
      },
      {
        'title': 'LG TV',
        'price': r'$330',
        'image': 'assets/images/LG tv.png',
        'sizes': null,
      },
      {
        'title': 'Airpods',
        'price': r'$333',
        'image': 'assets/images/Airpoads.png',
        'sizes': null,
      },
      {
        'title': 'Jacket',
        'price': r'$400',
        'image': 'assets/images/jacket.png',
        'sizes': ['S', 'M', 'L', 'XXL'],
      },
      {
        'title': 'Hoodie',
        'price': r'$50',
        'image': 'assets/images/hoodi.png',
        'sizes': ['S', 'M', 'L', 'XL'],
      },
      {
        'title': 'Casual T-Shirt',
        'price': r'$70',
        'image': 'assets/images/casual.png',
        'sizes': ['S', 'M', 'L', 'XL'],
      },
      {
        'title': 'Simple T-Shirt',
        'price': r'$65',
        'image': 'assets/images/simple.png',
        'sizes': ['S', 'M', 'L', 'XL'],
      },


    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.grey.shade100,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          categoryTitle,
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final item = products[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                    title: item['title'],
                    price: item['price'],
                    imagePath: item['image'],
                    sizes: item['sizes'],
                  ),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                          child: Image.asset(
                            item['image'],
                            width: double.infinity,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image, color: Colors.grey),
                            ),
                          ),
                        ),
                        const Positioned(
                          top: 10,
                          right: 10,
                          child: Icon(Icons.favorite_border, color: Colors.white, size: 22),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['title'],
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item['price'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color(0xff5C5AD0),
                                fontSize: 14,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Color(0xff5C5AD0),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.add, color: Colors.white, size: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
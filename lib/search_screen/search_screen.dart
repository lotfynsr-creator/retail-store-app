import 'package:flutter/material.dart';
import 'package:retailstoreapp/details_screen/details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  // قائمة جميع المنتجات
  final List<Map<String, dynamic>> _allProducts = [
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
      'price': r'$50',
      'image': 'assets/images/jacket.png',
      'sizes': ['S', 'M', 'L', 'XXL'],
    },
    {
      'title': 'Hoodie',
      'price': r'$400',
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

  // جعل القائمة فارغة في البداية
  List<Map<String, dynamic>> _filteredProducts = [];

  void _runFilter(String keyword) {
    List<Map<String, dynamic>> results = [];
    if (keyword.trim().isEmpty) {
      // إذا كان الحقل فارغاً اترك النتايج فارغة
      results = [];
    } else {
      results = _allProducts
          .where((item) =>
          item['title'].toString().toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    final queryText = _searchController.text.trim();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Search Bar & Navigation
              Row(
                children: [
                  if (ModalRoute.of(context)?.canPop ?? false) ...[
                    CircleAvatar(
                      backgroundColor: Colors.grey.shade100,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) => _runFilter(value),
                      autofocus: true,
                      decoration: InputDecoration(
                        hintText: 'Search here',
                        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                        prefixIcon: const Icon(Icons.search, color: Colors.black54),
                        suffixIcon: queryText.isNotEmpty
                            ? IconButton(
                          icon: const Icon(Icons.cancel, color: Colors.black45, size: 20),
                          onPressed: () {
                            _searchController.clear();
                            _runFilter('');
                          },
                        )
                            : null,
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        contentPadding: const EdgeInsets.symmetric(vertical: 0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. Results Header Title & Count
              if (queryText.isNotEmpty) ...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Results for ',
                        style: const TextStyle(color: Colors.grey, fontSize: 14),
                        children: [
                          TextSpan(
                            text: '" $queryText "',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${_filteredProducts.length} Results Found',
                      style: const TextStyle(
                        color: Color(0xff5C5AD0),
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],

              // 3. Grid of Filtered Products or Empty View
              Expanded(
                child: queryText.isEmpty
                    ? const Center(
                  child: Text(
                    'Type something to search...',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                )
                    : _filteredProducts.isEmpty
                    ? const Center(
                  child: Text(
                    'No products found',
                    style: TextStyle(color: Colors.grey, fontSize: 15),
                  ),
                )
                    : GridView.builder(
                  itemCount: _filteredProducts.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    // childAspectRatio: 0.82,
                    crossAxisSpacing: 14,
                    mainAxisSpacing: 14,
                  ),
                  itemBuilder: (context, index) {
                    final item = _filteredProducts[index];
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
                            SizedBox(
                              height: 130,
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                    child: Image.asset(
                                      item['image'],
                                      width: double.infinity,
                                      height: 130,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        color: Colors.grey.shade200,
                                        child: const Icon(Icons.image, color: Colors.grey),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                    top: 8,
                                    right: 8,
                                    child: Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 20,
                                    ),
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
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item['price'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xff5C5AD0),
                                          fontSize: 13,
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: const BoxDecoration(
                                          color: Color(0xff5C5AD0),
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 16,
                                        ),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
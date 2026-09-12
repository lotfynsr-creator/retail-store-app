import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:retailstoreapp/details_screen/details_screen.dart';
import 'package:retailstoreapp/products_screen/products_screen.dart';
import 'package:retailstoreapp/search_screen/search_screen.dart';
import '../widgets/product_card.dart';

// ============== Banner Data Model & List ==============
class _BannerData {
  final String title;
  final String subtitle;
  final String discount;
  final String imagePath;

  const _BannerData({
    required this.title,
    required this.subtitle,
    required this.discount,
    required this.imagePath,
  });
}

const List<_BannerData> _banners = [
  _BannerData(
    title: 'Get Winter Discount',
    subtitle: 'For Children',
    discount: '20% Off',
    imagePath: 'assets/images/bannar1.png',
  ),
  _BannerData(
    title: 'New Arrivals',
    subtitle: 'Shoes & Sneakers',
    discount: '15% Off',
    imagePath: 'assets/images/shoes.png',
  ),
  _BannerData(
    title: 'Tech Deals',
    subtitle: 'Electronics Sale',
    discount: '10% Off',
    imagePath: 'assets/images/Airpoads.png',
  ),
];

// ============== Home Screen Widget ==============
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  List<String> featuredName = ['Watch', 'Nike Shoes', 'Airpods'];
  List<String> featuredPrice = [r'$40', r'$430', r'$333'];
  List<String> featuredImage = [
    'assets/images/watch.png',
    'assets/images/shoes.png',
    'assets/images/Airpoads.png',
  ];
  List<List<String>?> featuredSizes = [
    ['38mm', '40mm', '42mm', '44mm'], // للساعة
    ['38', '40', '42', '43'],           // للحذاء
    null,                             // للسماعات (بدون مقاس)
  ];

  // قوائم قسم Most Popular
  List<String> popularName = ['LG TV', 'Hoodie', 'Jacket'];
  List<String> popularPrice = [r'$330', r'$50', r'$400'];
  List<String> popularImage = [
    'assets/images/LG tv.png',
    'assets/images/hoodi.png',
    'assets/images/jacket.png',
  ];
  List<List<String>?> popularSizes = [
    null,                             // للتلفزيون (بدون مقاس)
    ['S', 'M', 'L', 'XL'],            // للهودي
    ['S', 'M', 'L', 'XXL'],           // للجاكيت
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Header (User Greeting with dynamic Auth Username & Notification Icon)
              Row(
                children: [
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey.shade200,
                    child: const Icon(
                      Icons.person,
                      color: Colors.grey,
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello!',
                        style: TextStyle(fontSize: 13, color: Colors.grey),
                      ),
                      Builder(
                        builder: (context) {
                          final user = FirebaseAuth.instance.currentUser;
                          String userName = 'User';

                          if (user?.displayName != null && user!.displayName!.isNotEmpty) {
                            userName = user.displayName!;
                          } else if (user?.email != null && user!.email!.isNotEmpty) {
                            userName = user.email!.split('@').first;
                          }

                          return Text(
                            userName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications_none, color: Colors.black87),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. Search Bar
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const SearchScreen()),
                  );
                },
                child: AbsorbPointer(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search here',
                      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
                      prefixIcon: const Icon(Icons.search, color: Colors.black54),
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
              ),
              const SizedBox(height: 20),

              // 3. Banner PageView Slider
              SizedBox(
                height: 150,
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemCount: _banners.length,
                  itemBuilder: (context, index) {
                    final banner = _banners[index];
                    return Container(
                      margin: const EdgeInsets.only(right: 4),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xff5C5AD0),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  banner.title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  banner.discount,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  banner.subtitle,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              banner.imagePath,
                              width: 100,
                              height: 120,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image, color: Colors.white, size: 50),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),

              // Page Indicators (Dots)
              // Page Indicators (Dots)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _banners.length,
                      (index) => GestureDetector(
                    onTap: () {
                      _pageController.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      height: 8,
                      width: _currentPage == index ? 16 : 8,
                      decoration: BoxDecoration(
                        color: _currentPage == index
                            ? const Color(0xff5C5AD0)
                            : Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 4. Featured Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Featured',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductsScreen(categoryTitle: 'Featured Products'),
                        ),
                      );
                    },
                    child: const Text('See All', style: TextStyle(color: Color(0xff5C5AD0))),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredName.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              title: featuredName[index],
                              price: featuredPrice[index],
                              imagePath: featuredImage[index],
                              sizes: featuredSizes[index],
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        title: featuredName[index],
                        price: featuredPrice[index],
                        imagePath: featuredImage[index],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),

              // 5. Most Popular Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Most Popular',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProductsScreen(categoryTitle: 'Most Popular'),
                        ),
                      );
                    },
                    child: const Text('See All', style: TextStyle(color: Color(0xff5C5AD0))),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              SizedBox(
                height: 180,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularName.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailsScreen(
                              title: popularName[index],
                              price: popularPrice[index],
                              imagePath: popularImage[index],
                              sizes: popularSizes[index],
                            ),
                          ),
                        );
                      },
                      child: ProductCard(
                        title: popularName[index],
                        price: popularPrice[index],
                        imagePath: popularImage[index],
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
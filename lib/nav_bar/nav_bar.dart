import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:retailstoreapp/cart_screen/cart_screen.dart';
import 'package:retailstoreapp/home_screen/home_screen.dart';
import 'package:retailstoreapp/profile_screen/profile_screen.dart';
import 'package:retailstoreapp/search_screen/search_screen.dart';



class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  // ====== initial value =====
  int currIndex = 0;
  // ======= Screens ======
  List<Widget> screens = [HomeScreen(),SearchScreen(), CartScreen(),ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screens[currIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home,size: 30,), label: 'Home',),
          BottomNavigationBarItem(icon: Icon(Icons.search,size: 30,), label: 'Search',),


          // BottomNavigationBarItem(icon: Icon(Icons.shopping_bag,size: 30,),label: 'Cart'),
          BottomNavigationBarItem(
            icon: StreamBuilder<QuerySnapshot>(
              stream: FirebaseAuth.instance.currentUser != null
                  ? FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser!.uid)
                  .collection('cart')
                  .snapshots()
                  : null,
              builder: (context, snapshot) {
                int cartCount = 0;

                if (snapshot.hasData) {
                  // حساب مجموع كمية العناصر المضافة
                  cartCount = snapshot.data!.docs.fold<int>(0, (sum, doc) {
                    final data = doc.data() as Map<String, dynamic>;
                    return sum + ((data['quantity'] ?? 1) as int);
                  });
                }

                return Badge(
                  isLabelVisible: cartCount > 0, // يظهر فقط لو في عناصر في السلة
                  label: Text(
                    '$cartCount',
                    style: const TextStyle(color: Colors.white, fontSize: 10),
                  ),
                  backgroundColor: Colors.deepOrange,
                  child: const Icon(Icons.shopping_bag, size: 30),
                );
              },
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person,size: 30,),label: 'Profile'),
        ],
        currentIndex: currIndex,
        onTap: (value) {
          setState(() {
            currIndex = value;
          });
        },

        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff6055D8),
      ),
    );
  }
}
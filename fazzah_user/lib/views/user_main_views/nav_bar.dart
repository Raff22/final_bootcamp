import 'package:fazzah_user/models/provider_model.dart';
import 'package:fazzah_user/models/user_model.dart';
import 'package:fazzah_user/views/user_main_views/Favorate_screen.dart';
import 'package:fazzah_user/views/user_main_views/home_view.dart';
import 'package:fazzah_user/views/user_main_views/more_screen.dart';
import 'package:fazzah_user/views/user_main_views/order_cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class NavBar extends StatefulWidget {
  NavBar(
      {super.key,
      required this.user,
      this.index = 0,
      this.provider,
      this.navshowRating = false});
  final UserModel user;
  int index;
  ProviderModel? provider;
  bool navshowRating;

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int _selectedIndex;
  late final List<Widget> _widgetOptions;
  late UserModel currUser;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  @override
  void initState() {
    _selectedIndex = widget.index;
    _widgetOptions = [
      MainView(
          user: widget.user,
          ratedprovider: widget.provider,
          showRating: widget.navshowRating),
      const FavorateScreen(),
      const OrderCartScreen(),
      MoreScreen(
        user: widget.user,
      )
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: Colors.grey[300]!,
              hoverColor: Colors.grey[100]!,
              gap: 8,
              activeColor: Colors.black,
              iconSize: 24,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: const Duration(milliseconds: 400),
              tabBackgroundColor: Colors.grey[100]!,
              color: Colors.black,
              tabs: const [
                GButton(
                  icon: Icons.home,
                  text: 'الرئيسية',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'المفضلة',
                ),
                GButton(
                  icon: Icons.shopping_cart,
                  text: 'الطلبات',
                ),
                GButton(
                  icon: Icons.more_horiz,
                  text: 'المزيد',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}

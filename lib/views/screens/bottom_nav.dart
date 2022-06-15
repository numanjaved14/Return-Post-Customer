import 'package:couriercustomer/views/screens/add_order_screen.dart';
import 'package:couriercustomer/views/screens/home_screen.dart';
import 'package:couriercustomer/views/screens/order_place/brand_select_screen.dart';
import 'package:couriercustomer/views/screens/orders_screen.dart';
import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  // MyNavigationBar ({Key key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    const HomeScreen(),
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = const HomeScreen(); // Our first view in viewport

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color(0xff404040),
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        const HomeScreen(); // if user taps on this dashboard tab will be active
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      currentTab == 0 ? 'assets/pin.png' : 'assets/home.png',
                      height: 20,
                    )
                  ],
                ),
              ),

              //Orders
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen =
                        const OrdersScreen(); // if user taps on this dashboard tab will be active

                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      currentTab == 1
                          ? 'assets/vectorpink.png'
                          : 'assets/vector.png',
                      height: 20,
                    )
                  ],
                ),
              ),
              //Chat
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = Text('Chat Page',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold));
                    // if user taps on this dashboard tab will be active
                    currentTab = 2;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      currentTab == 2 ? 'assets/chat2.png' : 'assets/chat.png',
                      height: 20,
                    )
                  ],
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    currentScreen = const BrandSelectScreen();
                    // if user taps on this dashboard tab will be active
                    currentTab = 3;
                  });
                },
                backgroundColor: const Color(0xffEB5757),
                child: const Icon(Icons.add),
              )
            ],
          ),
        ),
      ),
    );
  }

  // int _selectedIndex = 0;
  // static const List<Widget> _widgetOptions = <Widget>[
  //   Text('Home Page',
  //       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  //   Text('Search Page',
  //       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  //   Text('Profile Page',
  //       style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _selectedIndex = index;
  //   });
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: Center(
  //       child: _widgetOptions.elementAt(_selectedIndex),
  //     ),
  //     bottomNavigationBar: BottomNavigationBar(
  //         backgroundColor: const Color(0xff404040),
  //         items: const <BottomNavigationBarItem>[
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.home),
  //             label: 'fawad',
  //             backgroundColor: const Color(0xff404040),
  //             // title: Text('Home'),
  //           ),
  //           BottomNavigationBarItem(
  //             label: 'fawad',
  //             icon: Icon(Icons.search),
  //             backgroundColor: const Color(0xff404040),

  //             // title: Text('Search'),
  //           ),
  //           BottomNavigationBarItem(
  //             icon: Icon(Icons.person),
  //             label: 'fawad',
  //             backgroundColor: const Color(0xff404040),

  //             // title: Text('Profile'),
  //           ),
  //         ],
  //         // type: BottomNavigationBarType.shifting,
  //         currentIndex: _selectedIndex,
  //         selectedItemColor: Colors.black,
  //         // iconSize: 40,
  //         onTap: _onItemTapped,
  //         elevation: 5),
  //   );
  // }
}

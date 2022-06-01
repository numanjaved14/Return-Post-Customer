import 'package:flutter/material.dart';

class MyNavigationBar extends StatefulWidget {
  // MyNavigationBar ({Key key}) : super(key: key);

  @override
  _MyNavigationBarState createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int currentTab = 0; // to keep track of active tab index
  final List<Widget> screens = [
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    Text('Home Page',
        style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
  ]; // to store nested tabs
  final PageStorageBucket bucket = PageStorageBucket();
  Widget currentScreen = Text('Home Page',
      style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold)); // Our first view in viewport

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
                    currentScreen = Text('Home Page',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight
                                .bold)); // if user taps on this dashboard tab will be active
                    currentTab = 0;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.food_bank),
                    Text(
                      'Food Items',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 10,
                        color: currentTab == 0
                            ? Color.fromARGB(255, 78, 24, 167)
                            : Color(0xff8d8282),
                      ),
                    )
                  ],
                ),
              ),

              //Orders
              MaterialButton(
                minWidth: 40,
                onPressed: () {
                  setState(() {
                    currentScreen = Text('Home Page',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold));
                    // if user taps on this dashboard tab will be active
                    currentTab = 1;
                  });
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.person),
                    Text(
                      'Registered Users',
                      style: TextStyle(
                        fontFamily: 'Gilroy',
                        fontSize: 10,
                        color: currentTab == 1
                            ? Color.fromARGB(255, 29, 6, 112)
                            : Color(0xff8d8282),
                      ),
                    )
                  ],
                ),
              ),
              FloatingActionButton(
                onPressed: () {
                  setState(() {
                    currentScreen = Text('Page',
                        style: TextStyle(
                            fontSize: 35, fontWeight: FontWeight.bold));
                    // if user taps on this dashboard tab will be active
                    currentTab = 2;
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

import 'package:flutter/material.dart';
import 'package:rentease_kb/views/reservation_requests_UI.dart';
import 'package:rentease_kb/views/view_properties.dart';

class HomeUI extends StatefulWidget {
  const HomeUI({Key? key}) : super(key: key);

  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  Color navcolor = Color(0xFF532D29);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "RentEase",
          style: TextStyle(
            color: navcolor,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      drawer: _buildDrawer(),
      backgroundColor: Colors.white,
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: navcolor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
            backgroundColor: navcolor,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
            backgroundColor: navcolor,
          ),
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Your Name"),
            accountEmail: Text("your.email@example.com"),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(
              color: navcolor,
            ),
          ),
          ListTile(
            title: Text('Tenant List'),
            onTap: () {
              // Add your logic for the first button here
              Navigator.pushNamed(context, '/viewtenants');
            },
          ),
          ListTile(
            title: Text('Reservation Requests'),
            onTap: () {
              // Add your logic for the second button here
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ReservationRequestsUI(),
                ),
              );
            },
          ),
          ListTile(
            title: Text('Pay Rent'),
            onTap: () {
              // Add your logic for the third button here
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => PaymentOptionsScreen(),
              //   ),
              // );
            },
          ),
          ListTile(
            title: Text('Properties'),
            onTap: () {
              // Add your logic for the fourth button here
              Navigator.pushNamed(context, '/manageproperties');
            },
          ),
          ListTile(
            title: Text('View Properties'),
            onTap: () {
              // Add your logic for the fourth button here
              Navigator.pushNamed(context, '/viewproperties');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    switch (_currentIndex) {
      case 0:
        return HomeScreen();
      case 1:
        return NotificationScreen();
      case 2:
        return HistoryScreen();
      default:
        return Container(); // Placeholder, you can replace it with an appropriate widget
    }
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          //search
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: '   search here',
                ),
              ),
            ),
          ),
          SizedBox(height: 60),
          ElevatedButton(
            onPressed: () {
              // Add your logic for the third button here
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => RoomRentalForm(),
              //   ),
              // );
            },
            child: Text("Reserve"),
          ),
        ],
      ),
    );
  }
}

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Notification Screen"),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("History Screen"),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Profile Screen"),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Add your logic for the first button here
              },
              child: Text("Tenant List"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your logic for the second button here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReservationRequestsUI(),
                  ),
                );
              },
              child: Text("Reservation requests"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your logic for the third button here
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => PaymentOptionsScreen(),
                //   ),
                // );
              },
              child: Text("Pay Rent"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your logic for the fourth button here
              },
              child: Text("Properties"),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your logic for the second button here
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ViewProperties(),
                  ),
                );
              },
              child: Text("View Properties"),
            ),
          ],
        ),
      ),
    );
  }
}

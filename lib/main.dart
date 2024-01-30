import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:grocden_shop_01/firebase_options.dart';
import 'package:grocden_shop_01/pages/auth/login_page.dart';
import 'package:grocden_shop_01/pages/auth/shop_details.dart';
import 'package:grocden_shop_01/pages/auth/signup_page.dart';
import 'pages/home_page.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: LocalitySearchPage(),
      routes: {
        //'/':(context) => Root(),
        '/':(context)=>CheckLoggedIn(),
        '/home':(context) => MyHomePage(),
        '/login':(context) => LoginPage(),
        '/signup':(context) => SignupPage(),
        '/shopDetails':(context) => ShopDetailsPage(),
        // 'orders':(context) => ,
        // Notifications
      },
    );
  }
}

// class Root extends StatelessWidget{
//   final User? user = FirebaseAuth.instance.currentUser;
//
//   @override
//   Widget build(BuildContext context) {
//     if(user!=null) return MyHomePage();
//     else return LoginPage();
//   }
// }


class CheckLoggedIn extends StatefulWidget {
  @override
  _CheckLoggedInState createState() => _CheckLoggedInState();
}

class _CheckLoggedInState extends State<CheckLoggedIn> {
  bool _isLoading = true;
  late bool isLoggedIn;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Check if the user is logged in (replace with your authentication logic)
    isLoggedIn = await checkIfUserIsLoggedIn();

    if (isLoggedIn) {
      // If the user is logged in, initialize Firebase Messaging and handle FCM token
      await initFirebaseMessaging();
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(body: Center(child: CircularProgressIndicator())); // Display a loading indicator while initializing
    } else if(isLoggedIn){
      return MyHomePage(); // Redirect to the login page or other appropriate page
    } else {
      return LoginPage();
    }
  }
}

Future<bool> checkIfUserIsLoggedIn() async {
  // Implement your user authentication logic here (e.g., using FirebaseAuth)
  // Return true if the user is logged in, otherwise return false
  // Example:
  final user = FirebaseAuth.instance.currentUser;
  return user != null;
  return false; // Replace with your authentication logic
}

Future<void> initFirebaseMessaging() async {
  final fcmToken = await FirebaseMessaging.instance.getToken();
  final user = FirebaseAuth.instance.currentUser;
  final userId = user?.uid;
  print('FCM Token: $fcmToken');

  if (fcmToken != null) {
    try {
      // Store the FCM token in Firestore (replace 'userId' with the actual user's ID)
      await FirebaseFirestore.instance
          .collection('shopCollection')
          .doc(userId) // user's UID
          .collection('fcm_tokens')
          .doc(fcmToken)
          .set({
        'token': fcmToken,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('FCM Token stored in Firestore.');
    } catch (e) {
      print('Error storing FCM Token in Firestore: $e');
    }
  }

  // Set up Firebase Messaging handlers
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print('Got a message whilst in the foreground!');
    print('Message data: ${message.data}');

    if (message.notification != null) {
      print('Message also contained a notification: ${message.notification}');
    }
  });

  FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) async {
    // Handle token refresh here (update it in Firestore if needed)
    if (fcmToken != null) {
      try {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('userId') // Replace 'userId' with the actual user's ID
            .collection('fcm_tokens')
            .doc(fcmToken)
            .set({
          'token': fcmToken,
          'createdAt': FieldValue.serverTimestamp(),
        });
        print('Refreshed FCM Token stored in Firestore.');
      } catch (e) {
        print('Error storing refreshed FCM Token in Firestore: $e');
      }
    }
  });
}
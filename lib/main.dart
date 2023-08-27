import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:practice_application/home.dart';
import 'package:practice_application/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:practice_application/forgotPassword.dart';
import 'package:practice_application/calendar.dart';
import 'package:practice_application/login_data.dart';
import 'package:practice_application/search.dart';
import 'package:provider/provider.dart';
import 'package:practice_application/addNote.dart';
import 'activity.dart';
import 'addressCard.dart';
import 'listFirm.dart';
import "map.dart";
import "map_data.dart";
import 'database_data.dart';
import 'recommend.dart';
import 'profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int entryTrials = 0;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginData>(create: (context) => LoginData()),
        ChangeNotifierProvider<DatabaseData>(
            create: (context) => DatabaseData()),
        ChangeNotifierProvider<MapData>(create: (context) => MapData()),
      ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        routes: <String, WidgetBuilder>{
          '/login': (context) => PortraitLogin(),
          '/forgotpassword': (context) => forgotPassword(),
          '/home': (context) => Home(),
          '/calendar': (context) => calendar(),
          '/addNote': (context) => addNote(),
          '/search': (context) => search(MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width),
          '/map': (context) => CompanyMap(),
          '/address': (context) => AddressCard(),
          '/profile': (context) => Profile(),
          '/activity': (context) => activity(),
          '/list': (context) => ListFirm(),
          '/recommend': (context) => Recommend(
              MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width),
        },
        home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Home();
            } else {
              return PortraitLogin();
            }
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

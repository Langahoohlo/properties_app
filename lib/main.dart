import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:properties_app/providers/user_providers.dart';
import 'package:properties_app/responsive/mobile_layout.dart';
import 'package:properties_app/responsive/responsive_layout.dart';
import 'package:properties_app/responsive/web_layout.dart';
import 'package:properties_app/widgets/google_sign_in_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "", //Enter firebase credentials
        appId: "", //
        messagingSenderId: "", //
        projectId: 'propertiesbylanga',
        storageBucket: 'propertiesbylanga.appspot.com', // <-- add this
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(Object context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => GoogleSignInProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        //home: const MainPage(),
        home: const ResponsiveLayout(
            mobileLayout: MobileLayout(), webLayout: WebLayout()),
        theme: ThemeData(primaryColor: Colors.black
            //primarySwatch: Colors.blueGrey
            ),
      ),
    );
  }
}

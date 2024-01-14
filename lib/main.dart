import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_business_manager/services/auth/auth_gate.dart';
import 'package:flutter_business_manager/services/auth/auth_service.dart';
import 'package:flutter_business_manager/services/database/firebase_service.dart';
import 'package:flutter_business_manager/services/firebase_options.dart';
import 'package:provider/provider.dart';




// -d chrome --web-renderer html

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
      ChangeNotifierProvider(create: (context) => AuthService(),
        child: const MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FirebaseService>(create: (context)=>FirebaseService(),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Green Heaven',
          home: AuthGate(),
        ));
  }
}

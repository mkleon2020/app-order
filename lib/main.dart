import 'package:flutter/material.dart';
import 'package:formvalidator/src/bloc/provider.dart';
import 'package:formvalidator/src/pages/home_page.dart';
import 'package:formvalidator/src/pages/login_page.dart';
import 'package:formvalidator/src/pages/producto_page.dart';
import 'package:formvalidator/src/pages/registro_page.dart';
import 'package:formvalidator/src/preferencias_usuario/preferencias_usuario.dart';
 
void main()  async{ 
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  
  runApp(MyApp());
  
}
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'login',
        routes: {
          'login': (BuildContext context) => LoginPage(),
          'home' : (BuildContext context) => HomePage(),
          'product' : (BuildContext context) => ProductPage(),
          'registro' : (BuildContext context) => RegistroPage(),
        },
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
      ) ,
    );
    
   
  }
}
import 'dart:convert';

import 'package:formvalidator/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:formvalidator/src/env/enviroment.dart';

class UsuarioProvider {

  final String _firebaseToken = 'AIzaSyB0hTZNPdtY6ZNEYJgJhgdATI4-5JSLkr8';

   final _prefs = new PreferenciasUsuario();

  Future <Map<String, dynamic>> login(String email, String password) async{
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };
    final resp = await http.post(
     '${Environment.apiUrl}/login',
     headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(authData)
    );

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    if(decodedResp.containsKey('token')){
      _prefs.token = decodedResp['token'];
      return {'ok': true, 'token': decodedResp['token']};
    }else{
      return {'ok': false, 'mensaje': decodedResp['msg']};
    }
  }
  // kuka

  Future<Map<String, dynamic>> nuevoUsuario(String nombre, String user,String email, String password) async {
  
    final authData = {
      'nombre': nombre,
      'user': user,
      'email': email,
      'password': password,
      
    };
    final resp = await http.post(
      '${Environment.apiUrl}/usuarios',
      headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(authData)
    );
    

    Map<String, dynamic> decodedResp = json.decode(resp.body);
    

    if(decodedResp.containsKey('token')){
       _prefs.token = decodedResp['token'];
      return {'ok': true, 'token': decodedResp['token']};
    }else{
      return {'ok': false, 'mensaje': decodedResp['msg']};
    }
  }
}
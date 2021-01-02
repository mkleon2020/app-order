
import 'dart:async';
import 'package:formvalidator/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
class LoginBloc with Validators {

   final _nombreController = BehaviorSubject<String>();
  final _userController = BehaviorSubject<String>();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();



  // Recuperar los datos del Stream
Stream<String> get nombreStream => _nombreController.stream;
Stream<String> get userStream => _userController.stream;

Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

// OBSERVABLES para conbinar STREAMS
// Stream<bool> get formValidStream => CombineLatestStream.combine4(emailStream, passwordStream,nombreStream,userStream, (e, p,v,c) => true); 
Stream<bool> get formValidStream => CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true); 

  //insertar valores al Stream
 Function(String) get changeNombre => _nombreController.sink.add;
  Function(String) get changeUser => _userController.sink.add;

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el ultimo valor ingresado a los stream
String get email => _emailController.value;
String get password => _passwordController.value;

String get nombre => _nombreController.value;
String get user => _userController.value;
  dispose(){
    _emailController?.close();
    _passwordController?.close();
    _nombreController?.close();
    _userController?.close();
  }


}
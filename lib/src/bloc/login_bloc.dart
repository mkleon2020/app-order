
import 'dart:async';
import 'package:formvalidator/src/bloc/validators.dart';
import 'package:rxdart/rxdart.dart';
class LoginBloc with Validators {

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();



  // Recuperar los datos del Stream
Stream<String> get emailStream => _emailController.stream.transform(validarEmail);
Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);

// OBSERVABLES para conbinar STREAMS
Stream<bool> get formValidStream => CombineLatestStream.combine2(emailStream, passwordStream, (e, p) => true); 

  //insertar valores al Stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el ultimo valor ingresado a los stream
String get email => _emailController.value;
String get password => _passwordController.value;
  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }


}
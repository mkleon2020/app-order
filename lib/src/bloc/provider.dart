import 'package:flutter/material.dart';

import 'login_bloc.dart';
export 'login_bloc.dart';

class Provider extends InheritedWidget{
factory Provider({Key key, Widget child}){
  //si la instancia es null crea una nueva instancia
  //de lo contrario regresara la misma instancia
  //esto con el fin de que no se pierda la informacion y mantenga la
  // instancia con los datos cargado y no lo redibuje
  if(_instancia == null){
    _instancia = new Provider._internal(key:key, child: child,);
  }

  return _instancia;
}
  Provider._internal({Key key, Widget child})
  :super(key: key, child: child);

static Provider _instancia;

  final loginBloc = LoginBloc();

  // Provider({Key key, Widget child})
  // :super(key: key, child: child);

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of ( BuildContext context ){
   return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
}

}
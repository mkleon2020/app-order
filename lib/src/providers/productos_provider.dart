

import 'dart:convert';

import 'package:formvalidator/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import 'package:formvalidator/src/models/producto_model.dart';

class ProductosProvider {
  final String _url ="https://flutter-24321.firebaseio.com";
   final _prefs = new PreferenciasUsuario();


  Future<bool> crearProducto(ProductoModel producto) async {
    final url = '$_url/productos.json?auth=${_prefs.token}';
   
    final resp = await http.post(url,body:productoModelToJson(producto) );
    final decodeData = json.decode(resp.body);
    print(decodeData);
    return true;

  }

  Future<List<ProductoModel>> cargarProductos() async{
    final url = '$_url/productos.json';
    final resp = await http.get(url);
    final Map<String, dynamic> decodeData = json.decode(resp.body);

    final List<ProductoModel> productos = new List();

    if(decodeData == null) return [];

    decodeData.forEach((id, prod) { 
     
      final prodTemp = ProductoModel.fromJson(prod);
      prodTemp.id = id;
      productos.add(prodTemp);

    });
    return productos;
  }


  Future<int> borrarProducto( String id) async{
    final url = '$_url/productos/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);
    return 1;
  }
}
import 'package:flutter/material.dart';
import 'package:formvalidator/src/models/producto_model.dart';
import 'package:formvalidator/src/providers/productos_provider.dart';
import 'package:formvalidator/src/utils/utils.dart' as utils;

class ProductPage extends StatefulWidget {

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final formKey = GlobalKey<FormState>();
  final productoProvider = new ProductosProvider();

  ProductoModel producto = new ProductoModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
        actions: [
        IconButton(
          icon: Icon(Icons.photo_size_select_actual), 
          onPressed: (){}
          ),
         IconButton(
          icon: Icon(Icons.camera_alt), 
          onPressed: (){}
          ),
        ],
       ) ,
       body: SingleChildScrollView(
         child: Container(
           padding: EdgeInsets.all(15.0),
           child:Form(
             key: formKey,
             child: Column(
               children: [
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                _crearBoton()
               ],
             )
            ) ,
         ),
       ),
     
    );
    
  }

 Widget _crearNombre() {
  
   return TextFormField(
     initialValue:producto.titulo ,
     textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
       labelText: 'Producto',
    ),
    onSaved: (value) => producto.titulo = value,
    validator: (value){
      if(value.length < 3){
        return 'Ingrese el nombre del producto';
      }else{
        return null;
      }
    },
   );
 }

 Widget _crearPrecio() {
    return TextFormField(
      initialValue:producto.valor.toString() ,
      keyboardType: TextInputType.numberWithOptions(decimal:true),
      decoration: InputDecoration(
        labelText: 'Precio',
      ),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value){
        if(utils.isNumeric(value)){
          return null;
        }else{
          return 'Solo numeros';
        }
      },
   );
 }

 Widget _crearBoton() {
  return RaisedButton.icon(
     onPressed: _submit, 
     icon: Icon(Icons.save), 
     label: Text('Guardar'),
     color: Colors.deepPurple,
     textColor: Colors.white,
     shape: RoundedRectangleBorder(borderRadius:BorderRadius.circular(20.0) ),
  );
 }

 void _submit(){
    if(!formKey.currentState.validate()) return;
// esta funcion dispara todos los set state de los form
   formKey.currentState.save();

   // enviar informacion al provider para guardar la data
   productoProvider.crearProducto(producto);

   
   
 }

 Widget _crearDisponible() {
   return SwitchListTile(value: producto.disponible, 
   title: Text('Disponible'),
   activeColor: Colors.deepPurple,
   onChanged: (value) => setState((){
     producto.disponible = value;
   })
   );
 }
}
import 'package:mysql1/mysql1.dart';
//la clase padres
abstract class Usuario {
  //Propiedades
  int? id;
  String? nombre;
  String? fechaNacimiento;
  String? genero;
  String? direccion;
  String? telefono;
  String? correoElectronico;

  //Constructor
  Usuario(this.id, this.nombre, this.fechaNacimiento, this.genero, this.direccion, this.telefono, this.correoElectronico);
  fromMap(ResultRow row);

  //Método para mostrar la información de la persona 
  mostrarInformacion();

} 

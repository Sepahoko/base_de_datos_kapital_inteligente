import 'package:mysql1/mysql1.dart';
import 'Database.dart';

class Profesor {
  //Propiedades
  int? _idprofesor;
  String? _nombre;
  String? _password;
  String? _fechaNacimiento;
  String? _correo;
  String? _telefono;
  String? _direccion;
  String? _genero;
  String? _inicioContrato;
  String? _finContrato;

  // Getters y setters
  String? get nombre {
    return this._nombre;
  }

  int? get idprofesor{
    return this._idprofesor;
  }

  set nombre(String? texto) {
    this._nombre = texto;
  }

  String? get password {
    return _password;
  }

  set password(String? texto) {
    this._password = texto;
  }

  // Constructores
  Profesor();

  Profesor.fromMap(ResultRow map) {
    this._idprofesor = map['idprofesor'];
    this._nombre = map['nombre'];
    this._password = map['password'];
  }

  // Métodos
  loginProfesor() async {
    var conn = await Database().conexion();
    try {
      var resultado = await conn.query('SELECT * FROM usuarios WHERE nombre = ?', [this._nombre]);
      Profesor profesor = Profesor.fromMap(resultado.first);
      if (this._password == profesor.password) {
        return profesor;
      } else
        return false;
      } catch (e) {
      print(e);
      return false;
      } finally {
      await conn.close();
    }
  }

   insertarProfesor() async {
    var conn = await Database().conexion();
    try {
      await conn.query('INSERT INTO profesores (nombre, password, fechaNacimiento, correo, telefono, direccion, genero, inicioContrato, finContrato) VALUES (?,?,?,?,?,?,?,?,?)',
          [_nombre, _password, _fechaNacimiento, _correo, _telefono, _direccion, _genero, _inicioContrato, _finContrato]);
      print('Profesor insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}
import 'package:mysql1/mysql1.dart';
import 'Database.dart';

class Alumno{
  //Propiedades
  int? _idalumno;
  String? _nombre;
  String? _password;
  String? curso;
  String? grupo;
  String? fechaNacimiento;
  String? correo;
  String? telefono;
  String? direccion;
  String? genero;
  String? fechaIngreso;
  String? fechaGraduacion;

  //getters y setters
   String? get nombre {
    return this._nombre;
  }

  int? get idprofesor{
    return this._idalumno;
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
  Alumno();

  Alumno.fromMap(ResultRow map) {
    this._idalumno = map['idalumno'];
    this._nombre = map['nombre'];
    this._password = map['password'];
  }

  // Métodos
  loginAlumno() async {
    var conn = await Database().conexion();
    try {
      var resultado = await conn.query('SELECT * FROM alumnos WHERE nombre = ?', [this._nombre]);
      Alumno alumno = Alumno.fromMap(resultado.first);
      if (this._password == alumno.password) {
        return alumno;
      } else
        return false;
      } catch (e) {
      print(e);
      return false;
      } finally {
      await conn.close();
    }
  }

  insertarAlumno() async {
    var conn = await Database().conexion();
    try {
      await conn.query('INSERT INTO alumnos (nombre, password, curso, grupo, fechaNacimiento, direccion, genero, inicioContrato, finContrato) VALUES (?,?,?,?,?,?,?,?,?)',
          [_nombre, _password, _curso, _grupo, _fechaNacimiento, _direccion, _genero, _inicioContrato, _finContrato]);
      print('Profesor insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }
}
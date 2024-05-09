import 'package:mysql1/mysql1.dart';
import 'Database.dart';

class Alumno{
  //Propiedades
  int? _idalumno;
  String? _nombre;
  String? _password;
  String? _curso;
  String? _grupo;
  int faltas = 0;
  String? _fechaNacimiento;
  String? _correo;
  String? _telefono;
  String? _direccion;
  String? _genero;
  String? _fechaIngreso;
  String? _fechaGraduacion;

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
    this.faltas = map['faltas'];
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
      await conn.query('INSERT INTO alumnos (nombre, password, curso, grupo, faltas, fechaNacimiento, correo, telefono, direccion, genero, fechaIngreso, fechaGraduacion) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)',
          [_nombre, _password, _curso, _grupo, faltas, _fechaNacimiento, _correo, _telefono, _direccion, _genero, _fechaIngreso, _fechaGraduacion]);
      print('Alumno insertado correctamente');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  all() async {
    var conn = await Database().conexion();
    try {
      var resultado = await conn.query('SELECT * FROM alumnos');
      List<Alumno> alumnos =
          resultado.map((row) => Alumno.fromMap(row)).toList();
      return alumnos;
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  justificarFaltas() async{
    var conn = await Database().conexion();
    faltas--;
    try {
        await conn.query('UPDATE alumnos SET faltas = ? WHERE idalumno = ?',[faltas,_idalumno]);
        print('Se ha justificado la falta');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }

  sumarFaltas() async{
    var conn = await Database().conexion();
    faltas++;
    try {
        await conn.query('UPDATE alumnos SET faltas = ? WHERE idalumno = ?',[faltas,_idalumno]);
        print('Se ha añadido la falta');
    } catch (e) {
      print(e);
    } finally {
      await conn.close();
    }
  }  

  getAlumno()async{
    var conn = await Database().conexion();
    try{
      var resultado = await conn.query('SELECT idalumno FROM alumno WHERE nombre = ?', [nombre]);
      return resultado;
    } catch(e){
      print(e); 
    } finally{
      await conn.close();
    }
  }
}
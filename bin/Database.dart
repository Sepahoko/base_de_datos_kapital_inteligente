import 'package:mysql1/mysql1.dart';

class Database {
  // Propiedades
  final String _host = 'localhost';
  final int _port = 3306;
  final String _user = 'root';

  // Métodos
  instalacion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
    );
    var conn = await MySqlConnection.connect(settings);
    try{
      await _crearDB(conn);
      await _crearTablaProfesores(conn);
      await _crearTablaAlumnos(conn);
      await conn.close();
    } catch(e){
      print(e);
      await conn.close();
    } 
  }

  Future<MySqlConnection> conexion() async {
    var settings = ConnectionSettings(
      host: this._host, 
      port: this._port,
      user: this._user,
      db: 'kapital'
    );
      
    return await MySqlConnection.connect(settings);
 
  }
  
  _crearDB (conn) async {
    await conn.query('CREATE DATABASE IF NOT EXISTS kapital');
    await conn.query('USE kapital');
    print('Conectado a kapital');
  }

  _crearTablaProfesores(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS profesores(
        idprofesor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        password VARCHAR(10) NOT NULL,
        fechaNaciento DATE,
        correo VARCHAR(50),
        telefono VARCHAR(9),
        direccion VARCHAR(50),
        genero VARCHAR(20),
        inicioContrato DATE,
        finContrato DATE
    )''');
    print('Tabla profesores creada');
  }

  _crearTablaAlumnos(conn) async {
    await conn.query('''CREATE TABLE IF NOT EXISTS alumnos(
        idalumno INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        nombre VARCHAR(50),
        password VARCHAR(20) NOT NULL,
        curso VARCHAR(50),
        grupo VARCHAR(10),
        fechaNaciento DATE,
        correo VARCHAR(50),
        telefono VARCHAR(9),
        direccion VARCHAR(50),
        genero VARCHAR(20),
        fechaIngreso DATE,
        fechaGraduacion DATE
    )''');
    print('Tabla alumnos creada');
  }  
}

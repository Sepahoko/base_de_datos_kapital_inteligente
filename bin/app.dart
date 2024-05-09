import 'dart:io';
import 'alumno.dart';
import 'profesor.dart';

class App{
  menuInicial() async{
    int? opcion;
    do{
      stdout.writeln('''Bienvenido a Kapital inteligente, elija la opcion
      1 - Crear Alumno
      2 - Crear Profesor 
      3 - Login Alumno
      4 - Login Profesor'''); 
      String respuesta = stdin.readLineSync()??'e';
      opcion = int.tryParse(respuesta); 
    } while (opcion == null|| opcion != 1 && opcion != 2 && opcion != 3 && opcion != 4);
    switch(opcion){
      case 1:
        crearAlumno();
      break;
      case 2:
        crearProfesor();
      break;
      case 3:
        Alumno alumno = await loginAlumno();
        menuLogueadoAlumno(alumno);
      break;
      case 4:
        Profesor profesor = await loginProfesor();
        menuLogueadoProfesor(profesor);
      break;
      default:
       print('Opción no válida');
    }
  }

  menuLogueadoAlumno(Alumno alumno) async {
    int? opcion;
    String? nombre = alumno.nombre;
    do{
      stdout.writeln('''Hola, $nombre, indicanos la opcion 
      1 - Imprimir horarios
      2 - Listar los alumnos
      3 - Justificar faltas 
      4 - Salir''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while(opcion == null || opcion != 1 && opcion !=2 && opcion !=3 && opcion !=4);
    switch(opcion){
      case 1:
        await imprimirHorarios();
        menuLogueadoAlumno(alumno);
        break;
      case 2:
        listarAlumnos();
        menuLogueadoAlumno(alumno);
        break;
      case 3:
        await alumno.justificarFaltas();
        menuLogueadoAlumno(alumno);
        break;
      case 4:
        print('Adiós');
        break;
      default:
        print('Opción no válida');
    }
  }

  menuLogueadoProfesor(Profesor profesor) async {
    int? opcion;
    String? nombre = profesor.nombre;
    do{
      stdout.writeln('''Hola, Don/Doña $nombre, indicanos la opcion 
      1 - Imprimir horarios
      2 - Listar todos los profesores
      3 - Asignar faltas a alumnos 
      4 - Salir''');
      String respuesta = stdin.readLineSync() ?? 'e';
      opcion = int.tryParse(respuesta);
    } while(opcion == null || opcion != 1 && opcion !=2 && opcion !=3 && opcion !=4);
    switch(opcion){
      case 1:
        await imprimirHorarios();
        menuLogueadoProfesor(profesor);
        break;
      case 2:
        listarProfesores();
        menuLogueadoProfesor(profesor);
        break;
      case 3:
        await asignarFaltas();
        menuLogueadoProfesor(profesor);
        break;
      case 4:
        print('Adiós');
        break;
      default:
        print('Opción no válida');
    }
  }

  crearAlumno() async {
    Alumno alumno = new Alumno();
    stdout.writeln('Introduce un nombre del alumno');
    alumno.nombre = stdin.readLineSync();
    stdout.writeln('Introduce una constraseña');
    alumno.password = stdin.readLineSync();
    alumno.password = alumno.password;
    await alumno.insertarAlumno();
    menuInicial();
  }

  crearProfesor() async {
    Profesor profesor = new Profesor();
    stdout.writeln('Introduce un nombre del Profesor');
    profesor.nombre = stdin.readLineSync();
    stdout.writeln('Introduce una constraseña');
    profesor.password = stdin.readLineSync();
    profesor.password = profesor.password;
    await profesor.insertarProfesor();
    menuInicial();
  }

  loginAlumno() async {
    Alumno alumno = new Alumno();
    stdout.writeln('Introduce tu nombre de alumno');
    alumno.nombre = stdin.readLineSync();
    stdout.writeln('Introduce tu constraseña');
    alumno.password = stdin.readLineSync();
    var resultado = await alumno.loginAlumno();
    if(resultado == false){
      stdout.writeln('Tu nombre de Alumno o contraseña son incorrectos');
      menuInicial();
    } else {
      return resultado;
    }
  }

  loginProfesor() async {
    Profesor profesor = new Profesor();
    stdout.writeln('Introduce tu nombre de usuario');
    profesor.nombre = stdin.readLineSync();
    stdout.writeln('Introduce tu constraseña');
    profesor.password = stdin.readLineSync();
    var resultado = await profesor.loginProfesor();
    if(resultado == false){
      stdout.writeln('Tu nombre de Profesor o contraseña son incorrectos');
      menuInicial();
    } else {
  
    }
  } 

  imprimirHorarios(){
    stdout.writeln(''' 
    ============================================================================================

    -------<Lunes>-------   -----<Martes>--------   -----<Miércoles>----  --------<Jueves>------
    Sistemas informáticos   Sistemas informáticos   Base de datos         Base de datos
    Sistemas informáticos   Sistemas informáticos   Base de datos         Base de datos
    Sistemas informáticos   Sistemas informáticos   Programación          Programación
    Programación            Fol                     Programación          Programación
    Programación            Fol                     Lenguajes de marcas   Entornos de desarrollo
    Base de datos           Fol                     Lenguajes de marcas   Entornos de desarrollo
    Base de datos           Inglés                  Inglés                Lenguajes de marcas
    Entornos de desarrollo                                                Lenguajes de marcas

    ============================================================================================
    ''');
  }

  listarAlumnos()async{
    List<Alumno> listadoAlumnos = await Alumno().all();
    for(Alumno elemento in listadoAlumnos){
      stdout.writeln(elemento.nombre);
    }
  }

   listarProfesores()async{
    List<Profesor> listadoProfesores = await Profesor().all();
    for(Profesor elemento in listadoProfesores){
      stdout.writeln(elemento.nombre);
    }
  }

  asignarFaltas() async {
    stdout.writeln('Ingrese el nombre del alumno al que desea asignar faltas:');
    String nombreAlumno = stdin.readLineSync() ?? '';
    Alumno alumno = await getAlumnoPorNombre(nombreAlumno);

    if (alumno != null) {
      await alumno.sumarFaltas();
      print('Faltas asignadas correctamente al alumno ${alumno.nombre}.');
    } else {
      print('No se encontró ningún alumno con el nombre proporcionado.');
    }
  } 
}

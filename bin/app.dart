import 'dart:io';

class App{
  menuInicial(){
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
        loginAlumno();
      break;
      case 4:
        loginProfesor();
      break;
      default:
       print('Opción no válida');
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
    
      }
    }

   loginProfesor() async {
     Usuario usuario = new Usuario();
      stdout.writeln('Introduce tu nombre de usuario');
      usuario.nombre = stdin.readLineSync();
      stdout.writeln('Introduce tu constraseña');
      usuario.password = stdin.readLineSync();
      var resultado = await usuario.loginUsuario();
      if(resultado == false){
        stdout.writeln('Tu nombre de Alumno o contraseña son incorrectos');
        menuInicial();
      } else {
    
      }
    } 

  }
}
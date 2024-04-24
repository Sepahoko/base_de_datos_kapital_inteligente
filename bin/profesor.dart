import 'usuario.dart';
//Clase hija profesor
class Profesor extends Usuario{
  //Propiedades
  List<String>? materiasQueEnsenia;
  String? gradoAcademico;
  String? experienciaLaboral;
  String? fechaContratacion;
  String? estadoLaboral;
  

  @override
  mostrarInformacion() {
    print('Información del profesor:');
    // Imprimir información específica del profesor
  }
}
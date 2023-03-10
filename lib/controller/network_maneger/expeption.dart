class CustomExeption implements Exception {
  final String errorDescreption;
  final int statusCode;

  CustomExeption({required this.errorDescreption,required this.statusCode});
}

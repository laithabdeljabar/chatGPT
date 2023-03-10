class Message {
  Message({
    required this.text,
    required this.index,
    this.like,
  });

  String text;
  int index;
  int? like;
}

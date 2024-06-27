class Model {
  String id = '';

  Model({this.id = ''}) {
    if (id == '') {
      id = DateTime.now().millisecondsSinceEpoch.toString();
    }
  }
}
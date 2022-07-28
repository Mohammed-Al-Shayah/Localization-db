class Notes {
  late int id;
  late String title;
  late String info;
  late int userId;

  Notes();
  Notes.fromMap({required Map<String,dynamic>rowMap}){
    id=rowMap['id'];
    title=rowMap['title'];
    info=rowMap['info'];
    userId=rowMap['userId'];
  }

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map= <String,dynamic> {};
    map['title']=title;
    map['info']=info;
    map['userId']=userId;
    return map;
  }

}
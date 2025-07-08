class Reply {
  Reply({
      this.name, 
      this.id,});

  Reply.fromJson(dynamic json) {
    name = json['name'];
    id = json['id'];
  }
  String? name;
  String? id;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['id'] = id;
    return map;
  }

}
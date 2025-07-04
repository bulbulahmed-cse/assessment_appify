import '../config/dependency.dart';

class Auth {
  Auth({
      this.type, 
      this.token,});

  Auth.fromJson(dynamic json) {
    type = json['type'];
    token = json['token'];
  }
  String? type;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['token'] = token;
    return map;
  }
  static Auth? get data {
    try{
      return instance.get<Auth>();
    } catch(e){
      return null;
    }
  }
}
class ModelClass {
  String? login;
  int? id;
  String? avatarUrl;


  ModelClass(
      {
        this.login,
        this.id,
        this.avatarUrl
      });

  factory ModelClass.fromJson(Map<String, dynamic> jsonData) {
    return ModelClass(
      id: jsonData['id'],
      login: jsonData['login'],
      avatarUrl: jsonData['avatar_url'],

    );
  }

  /*ModelClass.fromJson(Map<String, dynamic> json)
  {
    login = json['login'];
    id = json['id'];
    avatarUrl = json['avatar_url'];
  }*/

  Map<String, dynamic> toJson()
  {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['login'] = this.login;
    data['id'] = this.id;
    data['avatar_url'] = this.avatarUrl;
    return data;
  }

  static Map<String, dynamic> toMap(ModelClass music) => {
    'id': music.id,
    'login': music.login,
    'avatar_url': music.avatarUrl,

  };
}

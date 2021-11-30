class UserBless {
  final String id;
  final String fullName;
  final String telephone;
  final String email;
  final String tokenFirebase;
  final String tokenFacebook;
  final String tokenGoogle;

  UserBless(
    this.id,
    this.fullName,
    this.telephone,
    this.email,
    this.tokenFirebase,
    this.tokenFacebook,
    this.tokenGoogle,
  );

  UserBless.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        fullName = json['full_name'],
        telephone = json['telephone'],
        email = json['email'],
        tokenFirebase = json['tokenFirebase'],
        tokenFacebook = json['tokenFacebook'],
        tokenGoogle = json['tokenGoogle'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'telephone': telephone,
        'email': email,
        'tokenFirebase': tokenFirebase,
        'tokenFacebook': tokenFacebook,
        'tokenGoogle': tokenGoogle
      };

  @override
  String toString() {
    return 'UserBless{id: $id, fullName: $fullName, telephone: $telephone, email: $email, tokenFirebase: $tokenFirebase, tokenFacebook: $tokenFacebook, tokenGoogle: $tokenGoogle}';
  }
}

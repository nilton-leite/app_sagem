class Employees {
  final String id;
  final String fullName;
  final String cpf;
  final String telephone;
  final String email;
  final String description;

  Employees(
    this.id,
    this.fullName,
    this.cpf,
    this.telephone,
    this.email,
    this.description,
  );

  Employees.fromJson(Map<String, dynamic> json)
      : id = json['_id'],
        fullName = json['full_name'],
        cpf = json['cpf'],
        telephone = json['telephone'],
        email = json['email'],
        description = json['description'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'fullName': fullName,
        'cpf': cpf,
        'telephone': telephone,
        'email': email,
        'description': description,
      };

  @override
  String toString() {
    return 'Services{fullName: $fullName, cpf: $cpf, telephone: $telephone, email: $email, description: $description}';
  }
}

class Usuario {
  final int id;
  final String nome;
  final String email;

  Usuario(this.id, this.nome, this.email);

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(json['id'], json['nome'], json['email']);
  }
}

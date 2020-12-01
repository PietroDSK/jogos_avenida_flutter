class Jogo {
  final int id;
  final String nome;
  final String plataforma;
  final int nota;
  final double valor;
  final String foto;

  Jogo(this.id, this.nome, this.plataforma, this.nota, this.valor, this.foto);

  factory Jogo.fromJson(Map<String, dynamic> json) {
    return Jogo(json['id'], json['nome'], json['plataforma'], json['nota'],
        json['valor'].toDouble(), json['foto']);
  }
}

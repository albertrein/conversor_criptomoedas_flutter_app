class Moeda{
  String ?_sigla;
  String ?_nome;
  int ?_sequencia;

  Moeda(this._sigla, this._nome, this._sequencia);

  String get sigla => _sigla!;

  String get nome => _nome!;

  int get sequencia => _sequencia!;


  set sigla(String novo_sigla) {
    _sigla = novo_sigla;
  }

  set nome(String novo_nome) {
    _nome = novo_nome;
  }

  set sequencia(int novo_sequencia) {
    _sequencia = novo_sequencia;
  }

  Map<String, dynamic> toMap() {
    return {
      'sigla': _sigla,
      'nome': _nome,
      'sequencia': _sequencia,
    };
  }

  
  Moeda.fromMapObject(Map<String, dynamic> map) {
    this._sigla   = map['sigla'];
    this._nome = map['nome'];
    this._sequencia = map['sequencia'];
  }

  @override
  String toString() {
    return ('>'+sigla+' >'+nome);
  }
}
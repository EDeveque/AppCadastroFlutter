class cartaoentidade {
  late int? cartaoID;
  String? descricao;
  String? numero;
  String? validade;
  String? cvv;
  String? senha;

  cartaoentidade(
      {this.cartaoID,
      this.descricao,
      this.numero,
      this.cvv,
      this.senha,
      this.validade});

  @override
  String toString() {
    return '$cartaoID - $descricao - $numero';
  }

  getAllCards() {}
}

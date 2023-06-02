class WithDraw {
  final double amount;

  WithDraw(this.amount);

  toJson() {
    return {
      'amount': amount,
    };
  }
}

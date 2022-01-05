class Move {
  final String playerId;
  final String type;
  final String add;
  final String from;
  final String to;
  final String remove;

  Move(
      {required this.playerId,
      this.from = '',
      this.to = '',
      this.add = '',
      this.remove = '',
      required this.type});
}

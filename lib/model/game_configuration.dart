class GameConfiguration {
  int row;
  int column;
  List<dynamic> matrix;

  double widthGap;
  double heightGap;

  GameConfiguration(
      {required this.row,
      required this.column,
      required this.matrix,
      required this.widthGap,
      required this.heightGap});
}

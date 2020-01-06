class Field {
  Cell[][] cells;
  color[] colors;
  int cellSize;
  String imgPath;

  Field(String imgPath, int cellSize, int colorCount) {
    this.cellSize = cellSize;
    this.imgPath = imgPath;

    this.cells = getCellsFromTxt(this.imgPath, this.cellSize, colorCount);
    this.colors = getColorsFromTxt(this.imgPath, this.cellSize, colorCount);
  }

  Cell[][] createRandomCells(int xSize, int ySize) {
    Cell[][] cells = new Cell[xSize][ySize];

    for (int i = 0; i < cells[0].length; i++) {
      for (int j = 0; j < cells.length; j++) {
        cells[i][j] = new Cell(color(random(255), random(255), random(255)));
      }
    }

    for (int i = 0; i < cells[0].length; i++) {
      for (int j = 0; j < cells.length; j++) {
        cells[i][j] = new Cell(color(random(255), random(255), random(255)));
      }
    }

    return cells;
  }

  void changeCell(PVector cellPosition) {
    this.cells[int(cellPosition.x)][int(cellPosition.y)].isFilled = true;
  }

  Cell[][] getCellsFromTxt(String imgPath, int cellSize, int colorCount) {
    //String[] colorIndicesRows = subset(loadStrings("https://app.ato-n.de/emenzett/?p=" + imgPath + "&s=" + cellSize + "&c=" + colorCount + "&txt"), 1); 
    String[] colorIndicesRows = subset(loadStrings("https://app.ato-n.de/emenzett/mnz/?id=" + imgPath), 1);   

    int imgHeight = colorIndicesRows.length;
    int imgWidth = colorIndicesRows[0].split(",").length;

    Cell[][] cells = new Cell[imgWidth][imgHeight];

    for (int i = 0; i < imgHeight; i++) {
      String[] row =  colorIndicesRows[i].split(",");

      for (int j = 0; j < imgWidth; j++) {
        cells[j][i] = new Cell(int(row[j]));
      }
    }

    return cells;
  }


  color[] getColorsFromTxt(String imgPath, int cellSize, int colorCount) {
    //String[] colorStrgs = split(loadStrings("https://app.ato-n.de/emenzett/?p=" + imgPath + "&s=" + cellSize + "&c=" + colorCount + "&txt")[0], ",");
    String[] colorStrgs = split(loadStrings("https://app.ato-n.de/emenzett/mnz/?id=" + imgPath)[0], ",");   

    color[] colors = new color[colorStrgs.length];

    for (int i = 0; i < colorStrgs.length; i++) {
      String[] rgb = split(colorStrgs[i], ".");

      colors[i] = color(int(rgb[0]), int(rgb[1]), int(rgb[2]));
    }

    return colors;
  }

  color getFinishedColorFromCell(int x, int y) {
    return this.colors[this.cells[x][y].finishedColorIndex];
  }
}

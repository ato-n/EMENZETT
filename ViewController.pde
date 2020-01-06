class ViewController {

  float scaleFactor = 1;

  PVector Offset = new PVector(0, 0);

  float fontSize = 3;
  
  PVector relativeScalePosition = new PVector(0, 0);


  void drawField() {
    background(255, 255, 255);

    pushMatrix();
    this.updateProportions();

    textSize(fontSize * displayDensity);

    for (int i = 0; i < field.cells.length; i++) {
      for (int j = 0; j < field.cells[0].length; j++) {
        color clr = field.getFinishedColorFromCell(i, j);

        if (field.cells[i][j].isFilled) {
          fill(clr);
          rect(i * field.cellSize, j * field.cellSize, field.cellSize, field.cellSize);
        } else {
          fill(clr, 100);
          rect(i * field.cellSize, j * field.cellSize, field.cellSize, field.cellSize);

          fill(255, 255, 255);
          //text(field.cells[i][j].finishedColorIndex, 
          //  i * field.cellSize + field.cellSize * (1.0 / fontSize), 
          //  j * field.cellSize + field.cellSize * (1 - (1.0 / fontSize)));
        }
      }
    }
    popMatrix();
  }

  void updateProportions() {
    
    translate(relativeScalePosition.x, relativeScalePosition.y);
    scale(this.scaleFactor);
    translate(-relativeScalePosition.x, -relativeScalePosition.y);
    
    translate(-this.Offset.x / this.scaleFactor, -this.Offset.y / this.scaleFactor);
  }

  PVector getTileAt(PVector vector) {
    return new PVector(floor(getPositionAt(vector).x / field.cellSize), 
      floor(getPositionAt(vector).y / field.cellSize));
  }

  PVector getPositionAt(PVector vector) {
    return new PVector((vector.x + this.Offset.x) / this.scaleFactor, (vector.y + this.Offset.y) / this.scaleFactor);
  }

  String getContextAt(PVector vector) {
    PVector tileAt = this.getTileAt(vector);

    if (tileAt.x < field.cells.length && 
      tileAt.y < field.cells[0].length &&
      tileAt.x >= 0 &&
      tileAt.y >= 0) {

      return "cells";
    }

    return "";
  }

  void changeOffset(PVector vector) {
    this.Offset.add(vector);
  }

  void changeScaleFactor(float factor) {
    this.scaleFactor -= factor * (1.0 / field.cellSize) * 0.05;
    this.scaleFactor = constrain(this.scaleFactor, 0.3, 20);
  }
  
  void changeRelativeScalePosition(PVector position) {
    this.relativeScalePosition = position;
  }
}

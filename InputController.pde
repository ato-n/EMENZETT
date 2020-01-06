class InputController {

  PVector pos1 = new PVector(0, 0);
  PVector pos2 = new PVector(0, 0);
  PVector pos3 = new PVector(0, 0);
  PVector prevPos1 = new PVector(0, 0);
  PVector prevPos2 = new PVector(0, 0);
  PVector prevPos3 = new PVector(0, 0);

  void onFirstScreenTouch() {
    if (touches.length > 0) {
      this.pos1.set(touches[0].x, touches[0].y);
      this.prevPos1 = this.pos1.copy();
    }

    if (touches.length > 1) {
      this.pos2.set(touches[1].x, touches[1].y);
      this.prevPos2 = this.pos2.copy();

      // pos1 + 0.5 * (pos2 - pos1)
      this.pos3 = this.pos1.copy().add(pos2.copy().sub(pos1.copy()).mult(0.5));
      this.prevPos3 = this.pos3.copy();
    }
  }

  void onScreenTouch() {
    if (touches.length == 1) {
      inputAt(this.pos1, 1);

      this.prevPos1 = this.pos1.copy();
      this.pos1.set(touches[0].x, touches[0].y);
    } else if (touches.length > 1) {
      this.prevPos1 = this.pos1.copy();
      this.prevPos2 = this.pos2.copy();
      this.prevPos3 = this.pos3.copy();

      this.pos1.set(touches[0].x, touches[0].y);
      this.pos2.set(touches[1].x, touches[1].y);

      // pos1 + 0.5 * (pos2 - pos1)
      this.pos3 = this.pos1.copy().add(pos2.copy().sub(pos1.copy()).mult(0.5));


      inputAt(this.pos3, 2);
    }
  }

  void inputAt(PVector position, int touchCount) {
    if (touchCount == 1) {
      if (viewController.getContextAt(position) == "cells") {
        PVector cellPositions = viewController.getTileAt(position);
        field.changeCell(cellPositions);
      }
    } else if (touchCount > 1) {
      viewController.changeOffset(this.prevPos3.copy().sub(this.pos3.copy()));
      viewController.changeScaleFactor(this.prevPos1.dist(this.prevPos2) - this.pos1.dist(this.pos2));
      viewController.changeRelativeScalePosition(position);
    }
  }

  void input(boolean firstTouch) {
    if (firstTouch) {
      this.onFirstScreenTouch();
    }

    this.onScreenTouch();
  }
}

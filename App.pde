ViewController viewController;
InputController inputController;
Field field;

void setup() {
  fullScreen();
  noStroke();

  viewController = new ViewController();
  inputController = new InputController();
  field = new Field("daisy", 1, 2);

  viewController.drawField();
}

void draw() {
  viewController.drawField();
}

void touchStarted() {
  inputController.input(true);
}

void touchMoved() {
  inputController.input(false);
}

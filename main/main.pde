Menu currentMenu;
Button[] acceuilButtons;

void setup() {
  size (700, 700);
  currentMenu = Menu.ACCEUIL;
  acceuilButtons = new Button[1];
  acceuilButtons[0] = new Button (350, 350, 200, 50, "Jouer");
}




void draw() {
  if (currentMenu == Menu.ACCEUIL) {
    for (int i = 0; i < acceuilButtons.length; i++) {
      acceuilButtons[i].display();
    }
  }
}

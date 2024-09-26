class Button {
  private int x;
  private int y;

  private int width;
  private int height;

  private boolean centered;

  private String text;

  private int fontSize;
  private boolean autoFontSize;
  public int textRed;
  public int textGreen;
  public int textBlue;
  private String font;
  private boolean dirtyFont;

  public int red;
  public int green;
  public int blue;

  private int borderWidth;
  public int borderRed;
  public int borderGreen;
  public int borderBlue;

  private boolean roundedCorners;
  private int cornerRadius;

  public int hoverRedEffect;
  public int hoverGreenEffect;
  public int hoverBlueEffect;
  public int activatedRedEffect;
  public int activatedGreenEffect;
  public int activatedBlueEffect;

  Button (int x, int y, int w, int h, String text) {
    this.x = x;
    this.y = y;
    this.width = w;
    this.height = h;
    this.text = text;
    this.centered = true;

    this.autoFontSize = true;
    this.fontSize = 30;
    this.textRed = 20;
    this.textGreen = 200;
    this.textBlue = 180;
    this.font = PFont.list()[0];
    this.dirtyFont = true;

    this.red = 100;
    this.green = 100;
    this.blue = 100;
    this.borderWidth = 5;
    this.borderRed = 0;
    this.borderGreen = 0;
    this.borderBlue = 0;

    this.roundedCorners = true;
    this.cornerRadius = 200;

    this.hoverRedEffect = 50;
    this.hoverGreenEffect = 50;
    this.hoverBlueEffect = 50;

    this.activatedRedEffect = 50;
    this.activatedGreenEffect = 50;
    this.activatedBlueEffect = 50;
  }

  private void displayRect() {
    if (this.isMouseHovering()) {
      fill(red + hoverRedEffect, green + hoverGreenEffect, blue + hoverBlueEffect);
    } else {
      fill(red, green, blue);
    }

    if (this.borderWidth == 0) {
      noStroke();
    } else {
      strokeWeight(this.borderWidth);
      if (this.isActivated()) {
        stroke(borderRed + activatedRedEffect, borderGreen + activatedGreenEffect, borderBlue + activatedBlueEffect);
      } else {
        stroke(borderRed, borderGreen, borderBlue);
      }
    }
    if (this.centered) {
      if (this.roundedCorners) {
        rect(x-this.width/2, y-this.height/2, this.width, this.height, this.cornerRadius, this.cornerRadius, this.cornerRadius, this.cornerRadius);
      } else {
        rect(x-this.width/2, y-this.height/2, this.width, this.height);
      }
    } else {
      if (this.roundedCorners) {
        rect(x, y, this.width, this.height, this.cornerRadius, this.cornerRadius, this.cornerRadius, this.cornerRadius);
      } else {
        rect(x, y, this.width, this.height);
      }
    }
  }
  
  private void setFontSize() {
    float minWidth = 12/this.text.length() * this.width;

    float minHeight = 12/(textDescent() + textAscent()) * this.height;

    this.fontSize = (int)min(minWidth, minHeight) - 2;
  }

  private void displayText() {
    if (this.autoFontSize && this.dirtyFont) {
      this.setFontSize();
      this.dirtyFont = false;
      textFont(createFont(this.font, this.fontSize));
    } else {
      textFont(createFont(this.font, this.fontSize));
    }

    fill(textRed, textGreen, textBlue);
    textAlign(CENTER, CENTER);
    
    if (this.centered) {
      text(this.text, this.x, this.y);
    } else {
      text(this.text, this.x +this.width / 2, this.y + this.height / 2);
    }
  }

  public void display() {
    this.displayRect();
    this.displayText();
  }

  private void updateCornerRadius() {
    if (this.cornerRadius > height / 2) {
      this.cornerRadius = height / 2;
    }
  }

  public boolean isMouseHovering () {
    if (this.roundedCorners) {
      if (this.centered) {
        if ((mouseX > this.x - this.width / 2 && mouseX < this.x + this.width / 2 && mouseY > this.y + this.cornerRadius - this.height / 2 && mouseY < this.y + this.height / 2 - this.cornerRadius) ||
          (mouseX > this.x + this.cornerRadius - this.width / 2 && mouseX < this.x + this.width / 2 - this.cornerRadius && mouseY > this.y - this.height / 2 && mouseY < this.y + this.height / 2)) {
          return true;
        }
      } else {
        if ((mouseX > this.x && mouseX < this.x + this.width && mouseY > this.y + this.cornerRadius && mouseY < this.y + this.height - this.cornerRadius) ||
          (mouseX > this.x + this.cornerRadius && mouseX < this.x + this.width - this.cornerRadius && mouseY > this.y && mouseY < this.y + this.height)) {
          return true;
        }
      }

      this.updateCornerRadius();

      int distanceTopLeft;
      int distanceTopRight;
      int distanceBottomLeft;
      int distanceBottomRight;

      if (this.centered) {
        distanceTopLeft = distanceTwoPoints(mouseX, mouseY, this.x + this.cornerRadius - this.width / 2, this.y + this.cornerRadius - this.height / 2);
        distanceTopRight = distanceTwoPoints(mouseX, mouseY, this.x + this.width / 2 - this.cornerRadius, this.y + this.cornerRadius - this.height / 2);
        distanceBottomLeft = distanceTwoPoints(mouseX, mouseY, this.x + this.cornerRadius - this.width / 2, this.y + this.height / 2 - this.cornerRadius);
        distanceBottomRight = distanceTwoPoints(mouseX, mouseY, this.x + this.width / 2 - this.cornerRadius, this.y + this.height / 2 - this.cornerRadius);
      } else {
        distanceTopLeft = distanceTwoPoints(mouseX, mouseY, this.x + this.cornerRadius, this.y + this.cornerRadius);
        distanceTopRight = distanceTwoPoints(mouseX, mouseY, this.x + this.width - this.cornerRadius, this.y + this.cornerRadius);
        distanceBottomLeft = distanceTwoPoints(mouseX, mouseY, this.x + this.cornerRadius, this.y + this.height - this.cornerRadius);
        distanceBottomRight = distanceTwoPoints(mouseX, mouseY, this.x + this.width - this.cornerRadius, this.y + this.height - this.cornerRadius);
      }

      if (distanceTopLeft < this.cornerRadius || distanceTopRight < this.cornerRadius || distanceBottomLeft < this.cornerRadius || distanceBottomRight < this.cornerRadius) {
        return true;
      }
      return false;
    } else {
      if (this.centered) {
        return mouseX < this.x + this.width / 2 && mouseX > this.x - this.width / 2 && mouseY < this.y + this.height / 2 && mouseY > this.y - this.height / 2;
      } else {
        return mouseX < this.x + this.width && mouseX > this.x && mouseY < this.y + this.height && mouseY > this.y;
      }
    }
  }

  public boolean isActivated() {
    return mousePressed && this.isMouseHovering();
  }

  public void setColor(int red, int green, int blue) {
    this.red = red;
    this.green = green;
    this.blue = blue;
  }

  public void setColor(int black) {
    this.red = black;
    this.green = black;
    this.blue = black;
  }

  public void setBorderWidth (int bW) {
    this.borderWidth = bW;
  }

  public void setBorderColor (int red, int green, int blue) {
    this.borderRed = red;
    this.borderGreen = green;
    this.borderBlue = blue;
  }

  public void setBorderColor (int black) {
    this.borderRed = black;
    this.borderGreen = black;
    this.borderBlue = black;
  }

  public void setRoundedCorner (int radius) {
    this.roundedCorners = true;
    this.cornerRadius = radius;
  }

  public void setSquareCorner () {
    this.roundedCorners = false;
  }

  public void setX (int x) {
    this.x = x;
  }

  public void setY (int y) {
    this.y = y;
  }

  public void setWidth (int w) {
    this.width = w;
  }

  public void setHeight (int h) {
    this.height = h;
  }

  public void setText(String text) {
    this.text = text;
  }

  public void setFontSize (int size) {
    this.autoFontSize = false;
    this.fontSize = size;
  }

  public void setHoverColorEffect (int red, int green, int blue) {
    this.hoverRedEffect = red;
    this.hoverGreenEffect = green;
    this.hoverBlueEffect = blue;
  }

  public void setHoverColorEffect (int black) {
    this.hoverRedEffect = black;
    this.hoverBlueEffect = black;
    this.hoverGreenEffect = black;
  }

  public void setActivatedColorEffect (int red, int green, int blue) {
    this.activatedRedEffect = red;
    this.activatedGreenEffect = green;
    this.activatedBlueEffect = blue;
  }

  public void setActivatedColorEffect (int black) {
    this.activatedRedEffect = black;
    this.activatedGreenEffect = black;
    this.activatedBlueEffect = black;
  }

  public void setTextColor (int red, int green, int blue) {
    this.textRed = red;
    this.textGreen = green;
    this.textBlue = blue;
  }

  public void setTextColor (int black) {
    this.textRed = black;
    this.textGreen = black;
    this.textBlue = black;
  }

  public void setAutoFontSize (boolean auto) {
    this.autoFontSize = auto;
  }

  public void setFont (String font) {
    this.font = font;
  }
  
  public int getX () {
    return this.x;
  }

  public int getY () {
    return this.y;
  }

  public int getWidth() {
    return this.width;
  }

  public int getHeight() {
    return this.height;
  }

  public String getText() {
    return this.text;
  }

  public String getFont() {
    return this.font;
  }

  public int getFontSize() {
    return this.fontSize;
  }

  public int getBorderWidth() {
    return this.borderWidth;
  }

  public boolean getCornerRounded() {
    return this.roundedCorners;
  }

  public int getCornerRadius() {
    return this.cornerRadius;
  }
}


int distanceTwoPoints(int x1, int y1, int x2, int y2) {
  return (int)sqrt(pow(max(x1, x2) - min(x1, x2), 2) + pow(max(y1, y2) - min(y1, y2), 2));
}

class fallingStar {
  int mx;
  float my;
  int mAlpha;
  float mSize;

  //constructor
  fallingStar(int x, int y)
  {
    mx = x;
    my = y;
    mSize = random(14);
  }

  void display()
  {
    fill(255); //(170)
    ellipse(mx, my, mSize, mSize);
  }

  void fall()
  {
    mAlpha = mAlpha - 1;
    my = my + 1 + mSize / 5;
  }
}
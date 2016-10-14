String lines[], exp, txt;
int cnt, rate;
boolean show = true;
void setup() {
  txt = "";
  cnt = -1;
  rate = 150;
  exp = "key: operation\nright: next sentence\nleft: previous sentence\nup: increase reading speed\ndown: decrease reading speed\nenter: read current sentence again\nspace: mask/show sentence";
  lines = loadStrings("./text.txt"); //path to read file
  size(500, 500);
  fill(0);
  noLoop();
}
void draw() {
  background(255);
  textSize(20);
  textAlign(CENTER);
  if (cnt<0) {
    text("press RIGHT key to start", width/2, 200);
  }
  text(txt, 10, height/2-50, width-20, 100);
  textAlign(RIGHT);
  String rt = "rate: " + rate + " words/min";
  text(rt, 0, 0, width, 50);
  textAlign(LEFT);
  textSize(12);
  text(exp, 5, 5, 250, 200);
}

void say() {
  println(str(rate));
  if (cnt>=0) {
    String[] params = {"say", "-r", str(rate), lines[cnt]};
    exec(params);
  }
}

void keyPressed() {
  if (keyCode==RIGHT) {
    cnt = (cnt < lines.length - 1) ? cnt+1 : 0;
    say();
  }
  if (keyCode==LEFT) {
    cnt = (cnt > 0) ? cnt-1 : lines.length - 1;
    say();
  }
  if (keyCode==UP) {
    rate+=10;
  }
  if (keyCode==DOWN) {
    if(rate > 90) rate-=10;
  }
  if (keyCode==ENTER) {
    say();
  }
  if (key==' ') {
    show = !show;
    println("space");
  }
  redraw();
  if (cnt>=0) {
    txt = show ? lines[cnt] : "";
  }
}


String lines[], exp, txt, path;
int cnt, rate;
boolean show = true;
void setup() {
  txt = "";
  cnt = -1;
  rate = 150;
  exp = "key: operation\nright: next sentence\nleft: previous sentence\nup: increase reading speed\ndown: decrease reading speed\nenter: read current sentence again\nspace: mask/show sentence";
  size(500, 500);
  fill(0);
  noLoop();
}
void draw() {
  background(255);
  textSize(20);
  textAlign(CENTER);
  if (cnt<0) {
    text("select file and press RIGHT key to start", width/2, 200);
    fill(244, 232, 193);
    noStroke();
    rect(0, height-50, width, height);
    fill(0);
    text("select file", width/2, height-25);
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

void mousePressed(){
  if(mouseY>height-50){
    selectInput("Select a file to process:", "fileSelected");
  }
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    path = selection.getAbsolutePath() + "/";
    lines = loadStrings(path);
    println("User selected " + selection.getAbsolutePath());
  }
}

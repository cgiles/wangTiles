ArrayList<Tile> tiles=new ArrayList<Tile>();
int nbRow, nbCol;
boolean isDrawingGrid=false,isDrawingText=false;
Walker myWalker;
void setup() {
  size(1280, 640);
  nbCol=width/32;
  nbRow=height/32;
  textAlign(CENTER);
  imageMode(CENTER);
generateField();
myWalker=new Walker(nbCol,nbRow,tiles);
}

void draw() {
  background(30);

  for (int i=0; i<nbRow; i++) {
    for (int j=0; j<nbCol; j++) {

      int posX=j*32+16;
      int posY=i*32+16;
      int id=j+i*nbCol;

      pushStyle();
      //if (tiles.get(id%tiles.size()).returnRight())tint(255, 127, 127);
      image(tiles.get(id%tiles.size()).image, posX, posY);
      if(isDrawingText)text(tiles.get(id%tiles.size()).nb, posX, posY);
      popStyle();
    }
  }
  if (isDrawingGrid)drawGrid();
  //if(frameCount%3==0)
  myWalker.update();
  myWalker.display();
}
void drawGrid() {
  for (int i=0; i<width; i+=32) {
    stroke(127);
    line(i, 0, i, height);
  }
  for (int i=0; i<height; i+=32) {
    stroke(127);
    line(0, i, width, i);
  }
}
void keyReleased() {
  if (key=='c')isDrawingGrid=!isDrawingGrid;
   if (key=='v')isDrawingText=!isDrawingText;
   if(key=='b')myWalker.getTile();
}
void mouseReleased(){
  generateField();
  myWalker=new Walker(nbCol,nbRow,tiles);
}

void generateField(){
  tiles.clear();
int col=0, row=0;
  int nb=0;
  for (int i=0; i<nbRow; i++) {
    for (int j=0; j<nbCol; j++) {
      int id=(int)random(16);
      int fakeBin=0;
      nb=j+i*nbCol;

      int nbLeft=(col!=0)?nb-1:-1;
      int nbTop=(row!=0)?nb-nbCol:-1;
      fakeBin+=(nbLeft>=0&&tiles.get(nbLeft).returnRight())?100:0;
      fakeBin+=(nbTop>=0&&tiles.get(nbTop).returnDown())?1000:0;
      fakeBin+=((j+1)<nbCol)?(int)random(2):0;
      fakeBin+=((i+1)<nbRow)?(int)random(2)*10:0;
      String sFaBin=nf(fakeBin, 4);
      id=Integer.parseInt(sFaBin, 2);
      println(sFaBin+":"+id+":"+nb);
      String fileName=nf(id, 2)+".png";
      Tile tTile=new Tile(loadImage(fileName), id, nb);
      tiles.add(tTile);
      col++;
      println(col+" : "+row+" : "+nbRow+" : "+nbCol);
    }
    col=0;
    row++;
  }
}
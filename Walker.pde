class Walker {
  PVector position=new PVector();
  PVector destination=new PVector();
  int[] playList={0, 1, 2, 1};
  int pacManId=0;
  float pacManAngle=0;
  ArrayList<PImage> pacMan=new ArrayList<PImage>();
  int nbCol, nbRow;
  Tile onTile, prevTile;
  ArrayList<Tile> tiles;
  Walker(int nbColT, int nbRowT, ArrayList<Tile>tilesT) {
    nbCol=nbColT;
    nbRow=nbRowT;
    tiles=tilesT;
    do {
      int tileX=(int)random(nbCol);
      int tileY=(int)random(nbRow);
      onTile=tiles.get(tileX+tileY*nbCol);
      position.x=tileX*32+16;
      position.y=tileY*32+16;
      destination=position.copy();
    } while (onTile.binary.equals("0000"));
    for (int i=0; i<3; i++)pacMan.add(loadImage("pacman"+nf(i, 2)+".png"));
  }
  void display() {
    if(frameCount%10==0)pacManId++;
    /* pushStyle();
     stroke(255);
     fill(255, 0, 0);
     ellipse(position.x, position.y, 20, 20);*/
     pushMatrix();
     translate(position.x, position.y);
     rotate(pacManAngle);
    image(pacMan.get(playList[pacManId%playList.length]), 0,0);
  popMatrix();  
}
  void getTile() {
    int tileX=int(position.x-16)/32;
    int tileY=int(position.y-16)/32;
    int tileId=tileX+tileY*nbCol;
    onTile=tiles.get(tileId);
    //println(onTile.binary);
  }
  boolean move() {
    if (PVector.dist(position, destination)>1.0) {
      position.lerp(destination, 0.2);
      return true;
    } else {
      position=destination.copy();
      return false;
    }
  }
  void update() {
    
    if (!move()) {
      prevTile=tiles.get(onTile.nb);
      getTile();
      int nbWay=onTile.binary.length()-onTile.binary.replace("1", "").length()  ;
      //println(nbWay);
      ArrayList<Tile>destinationTile=new ArrayList<Tile>();
      if (onTile.binary.substring(3).equals("1")) {
        destinationTile.add(tiles.get(onTile.nb+1));
        
      }
      if (onTile.binary.substring(2, 3).equals("1")) {
        destinationTile.add(tiles.get(onTile.nb+nbCol));
       
    }
      if (onTile.binary.substring(1, 2).equals("1")) {
        destinationTile.add(tiles.get(onTile.nb-1));
   
    }
      if (onTile.binary.substring(0, 1).equals("1")) {
        destinationTile.add(tiles.get(onTile.nb-nbCol));
      
    } 
      if (destinationTile.size()>1) {
        destinationTile.remove(prevTile);
      }
      if (destinationTile.size()==1) {
        int nbT=destinationTile.get(0).nb;
        destination.x=(nbT%nbCol)*32+16;
        destination.y=(int)(nbT/nbCol)*32+16;
      } else {
        int nbT=destinationTile.get((int)random(destinationTile.size())).nb;
        destination.x=(nbT%nbCol)*32+16;
        destination.y=(int)(nbT/nbCol)*32+16;
  
    }
      PVector reference=new PVector(1,0,0);
      PVector normaDest=destination.copy();
      normaDest.sub(position);
      normaDest.normalize();
          pacManAngle=PVector.angleBetween(new PVector(1.0,0.0),normaDest);
        if(destination.y<position.y&&degrees(pacManAngle)==90){
        
          pacManAngle*=-1;
        }println(destination.cross(reference));println(pacManAngle);  
    }
  }
}
class Tile {
  PImage image;
  String binary;
  int id;
  int nb;
  Tile(PImage tImage, int tId, int tNb) {
    image=tImage;
    binary=binary(tId, 4);
    id=tId;
    nb=tNb;
  }
  boolean returnRight() {
    boolean result=false;
    if (binary.substring(3).equals("1"))result=true;
    return result;
  }
  boolean returnDown() {
    boolean result=false;
    if (binary.substring(2, 3).equals("1"))result=true;
  //  println(binary.substring(2, 3)+":"+result+":"+id+":"+nb+":"+binary);
    return result;
  }
}
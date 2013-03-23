static class Game {
  static int width = 900;
  static int height = 600;
  
  static float time = 1.0;
  static int gravity = 5;
}

// color #1 255,195,132
// color #2 246,170,134
// color #3 130,97,126
// color #4 72,76,113
// color #5 62,62,98


class Position {
  protected int x = 0;
  protected int y = 0;
  
  public Position( int x, int y ) {
     this.x = x;
     this.y = y;
  }
  
  public int X() { 
    return this.x;
  }
  
  public int Y() {
    return Game.height - this.y;
  } 
  
  public void move( int x, int y ) {
    this.x += x;
    this.y = Game.height - ( this.Y() - y );
  }
}

class Dimensions {
  private int x;
  private int y;
 
  public Dimensions() {
    this.x = 10;
    this.y = 10;
  } 
  
  public Dimensions( int x, int y ) {
    this.x = x;
    this.y = y; 
  }
  
  public int Y() {
   return this.y; 
  }
  
  public int X() {
   return this.x; 
  }
  
}

class World {
  Position position;
  Dimensions dimensions;
  
 public World () {
     this.position = new Position( 0, 0 );
     this.dimensions = new Dimensions( 900, 600 );  
 }
 
 public int getGround() {
   return 0;
 }
 
 public void render() {
    stroke( 255,195,132 );
    fill( 255,195,132 );
    rect( 
      this.position.X(), 
      this.position.Y() - this.dimensions.Y(), 
      this.dimensions.X(), 
      this.dimensions.Y() / 2
    );
 }
  
}

class Brick {
  
  Position position;
  Dimensions dimensions;
  
  int jump;
  
  public Brick() {
   this.position = new Position( 0, 0 );   
   this.dimensions = new Dimensions( 20, 20 );  
  }
  
  public Brick( Position position ) {
     this.position = position;
     this.dimensions = new Dimensions( 20, 20 );  
  }
  
  void render() {
    stroke( 130,97,126 );
    fill( 130,97,126 );
    rect( 
      this.position.X(), 
      this.position.Y() - this.dimensions.Y(), 
      this.dimensions.X(), 
      this.dimensions.Y() 
    );
  }
  
  Position getPosition() {
     return new Position( 
       this.position.X(),
       this.position.Y()
     );
  }
  
  
  //
  // edge finding methods for collision detection
  int getLeftEdge() {
     return this.getPosition().X(); 
  }
  
  int getRightEdge() {
     return this.getPosition().X() + this.dimensions.X();
  }
  
  int getTopEdge() {
    return this.getPosition().Y() + this.dimensions.Y();
  }
  
  int getBottomEdge() {
     return this.getPosition().Y(); 
  }
  
  //
  // brick actions
  void move( int distance ) {
    
    // sjekker om Brick er utenfor rammen   
    int newX = b.getPosition().X() + distance; // ny posisjon
    
    boolean tooFarRight = ( newX >= Game.width );
    boolean tooFarLeft = ( newX < 0 );
    
    if ( !tooFarRight && !tooFarLeft ) {
      b.position.move( distance, 0 );
    }
  }
  
  void jump() {
    if ( b.getPosition().Y() == 0 ) {
      b.position.move( 0, 100 ); // kan ikke hoppe, hvis ikke på bakken
    }
  }
  
}


/* runtime */

Brick b;
World w;

void setup() {
  background( 246,170,134 ); // setter bakgrunnsfargen [->] flytt til 'Properties' 
  
  size( Game.width, Game.height );

  b = new Brick();
  w = new World();
}


void draw() {
  
  background( 246,170,134 );
  
  
  if ( b.getPosition().Y() > w.getGround() ) {
    b.position.move( 0, -Game.gravity ); 
  }
  
  
  if ( keyPressed ) {
    if ( keyCode == RIGHT ) {
      b.move( 20 ); 
    } else if ( keyCode == LEFT ) {
      b.move( -20 ); 
    } 
  }
  
  w.render();
  b.render();
 
  text( "Brick X: " + b.getPosition().X(), 10, 30); 
  text( "Brick Y: " + b.getPosition().Y(), 10, 50);
  
}

void keyReleased() {
  if ( keyCode == UP ) {
    b.jump();
  }
}

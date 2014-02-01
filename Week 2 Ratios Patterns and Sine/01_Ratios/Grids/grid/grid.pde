int cell = 20; // Individual cell size
int cols, rows; // Total number of columns and rows

void setup() {
  size(800, 600);
  
  //Calculate number of cols and rows
  //based on cell size
  reset();
  
  println("Use UP/DOWN to control row intervals. LEFT/RIGHT to control column intervals.");  
  stroke(255);
  fill(0);
}

void draw() {
  background(255);
  // CREATE A GRID WITH SO MANY COLUMNS...
  for (int col = 0; col < cols; col++) {
    // The x-location of the cell is a function of
    // the column the cell is in and the size of the cell
    float x = col*cell;
    
    // ...AND SO MANY ROWS
    for (int row = 0; row < rows; row++) {
      // The y-location of the cell is a function of
      // the row it's in and the size of the cell
      float y = row*cell; 
      rect(x, y, cell, cell);
    }
  }
}

void reset() {
  // The number of rows and columns is a function of
  // how many times a cell fits across/down the window
  cols = width/cell;
  rows = height/cell;  
}

void keyPressed() {
  
  switch(keyCode) {
  case UP:
    cell++;  
    break;
  case DOWN:
    cell--;
    break;
  }
  
  cell = constrain(cell, 1, width);
  reset();
  println("CELL SIZE: " + cell);
}


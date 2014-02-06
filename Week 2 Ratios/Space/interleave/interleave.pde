int cell = 20; // Individual cell size
int cols, rows; // Total number of columns and rows
int colINT = 1; // Starting interval for columns
int rowINT = 1; // Starting interval for rows

void setup() {
  size(800, 600);
  
  // The number of rows and columns is a function of
  // how many times a cell fits across/down the window
  cols = width/cell;
  rows = height/cell;
  
  println("Use UP/DOWN to control row intervals. LEFT/RIGHT to control column intervals.");
  
  background(255);
  noStroke();
}

void draw() {
  
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
      
      /* 
      * Why is the result so different if you reverse the order of the next 2 lines of code?
      * What if they were mutually exclusive?
      */
      // Fill every *th column black
      if (col%colINT == 0) fill(0);
      // Fill every *th row red
      if (row%rowINT == 0) fill(255, 0, 0);
      
      rect(x, y, cell, cell);
    }
  }
}

void keyPressed() {
  
  switch(keyCode) {
  case UP:
    rowINT++;  
    break;
  case DOWN:
    rowINT--;
    break;
  case RIGHT:
    colINT++;
    break;
  case LEFT:
    colINT--;
    break;
  }
  
  colINT = constrain(colINT, 1, cols);
  rowINT = constrain(rowINT, 1, rows);

  println("COL INTERVAL: " + colINT + "\t\tROW INTERVAL: " + rowINT);
}


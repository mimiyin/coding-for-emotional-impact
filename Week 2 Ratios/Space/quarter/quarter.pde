int cell = 5; // Individual cell size
int cols, rows; // Total number of columns and rows
int colTH, rowTH; // Threshold for columns and rows

void setup() {
  size(800, 600);

  // The number of rows and columns is a function of
  // how many times a cell fits across/down the window
  cols = width/cell;
  rows = height/cell;

  // Start in the middle
  colTH = cols/2;
  rowTH = rows/2;
  
  background(255);
  noStroke();
  
  println("Use arrow keys to adjust column and row thresholds.");
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

      fill(255, 0, 0);
      
      // Fill cells to the right of colTH
      // and below rowTH black
      if (col>=colTH || row>=rowTH) fill(0);

      rect(x, y, cell, cell);
    }
  }
}

void keyPressed() {

  switch(keyCode) {
  case UP:
    rowTH--;  
    break;
  case DOWN:
    rowTH++;
    break;
  case RIGHT:
    colTH++;
    break;
  case LEFT:
    colTH--;
    break;
  }

  colTH = constrain(colTH, 0, cols);
  rowTH = constrain(rowTH, 0, rows);

  println("COL THRESHOLD: " + colTH + "\t\tROW THRESHOLD: " + rowTH);
}


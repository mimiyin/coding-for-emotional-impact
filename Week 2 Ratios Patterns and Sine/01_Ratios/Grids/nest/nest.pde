int cell = 5; // Individual cell size
int cols, rows; // Total number of columns and rows
float colBD, rowBD; // Threshold for columns and rows
boolean auto;

void setup() {
  size(800, 600);

  // The number of rows and columns is a function of
  // how many times a cell fits across/down the window
  cols = width/cell;
  rows = height/cell;
  
  // Initialize with a 20x20 square in the middle
  colBD = 10;
  rowBD = 10;

  background(255);
  noStroke();
  
  println("Use arrow keys to adjust column and row boundaries. Press ENTER for auto mode.");
}

void draw() {
  if (auto) {
    colBD +=random(-10, 10);
    rowBD +=random(-10, 10);
    
    // Allow it to disappear or obliterate the window
    colBD = constrain(colBD, -cols/2, cols);
    rowBD = constrain(rowBD, -rows/2, rows);
  }


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

      // Fill cells in the middle with black
      if ((col>=(cols/2-colBD) && col <(cols/2+colBD)) && (row >=(rows/2-rowBD) && row <(rows/2+rowBD))) fill(0);

      rect(x, y, cell, cell);
    }
  }
}

void keyPressed() {

  switch(keyCode) {
  case UP:
    rowBD++;  
    break;
  case DOWN:
    rowBD--;
    break;
  case RIGHT:
    colBD++;
    break;
  case LEFT:
    colBD--;
    break;
  case ENTER:
    auto = !auto;
    colBD = 0;
    rowBD = 0;
    break;
  }

  colBD = constrain(colBD, 0, cols/2);
  rowBD = constrain(rowBD, 0, rows/2);

  println("COL BOUNDARY: " + colBD + "\t\tROW BOUNDARY: " + rowBD);
}


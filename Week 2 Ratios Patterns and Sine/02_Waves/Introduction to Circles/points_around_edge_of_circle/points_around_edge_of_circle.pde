/* This sketch draws a dot that goes around the edge of a circle 
with a radius (r) anchored at center point (centerX, centerY)
*/


// center of the circle
float centerX;
float centerY;

// x and y location of the point moving around the circumference of the circle
float xLoc = 0;
float yLoc = 0;

// how far around the circle
float degree = 0;

// radius of the circle (aka how big is the circle)
float radius = 100;


void setup() {
  size(400,400);
  
  //Dynamically calculate the center of the circle
  //By centering it in the Processing window
  centerX = width/2;
  centerY = height/2;
  
}

void draw() {
 
 background(255);
 
 noStroke();
 
 // Draw a small circle in the center of the circle 
 fill(0); 
 ellipse(width/2, height/2, 10, 10);
 
 // Calculate the x-location of the dot moving around the edge of the circle
 // centerX offsets the circle around the center point defined by centerX
 // radians() turns degrees into radians (PI)
 // cos() gives you the x-location of the point on the edge of the circle
 // radius tells you how far away from the center of the circle the point is
 xLoc = centerX + (radius * cos(radians(degree)));
 
 // Calculate the y-location of the dot moving around the edge of the circle
 // centerY offsets the circle around the center point defined by centerY
 // radians() turns degrees into radians (PI)
 // sin() gives you the x-location of the point on the edge of the circle
 // radius tells you how far away from the center of the circle the point is
 yLoc = centerY + (radius * sin(radians(degree)));
 
 // Draw a small circle moving around the edge of the circle
 fill(255,0,0);
 ellipse(xLoc, yLoc, 10, 10);

 // Increment the degree to move the point around the edge of the circle
 degree++; 
 
 
 // Try changing the value of radius in some every time through draw and see what happens!  
 // Try changing the value of value of centerX and centerY every time through draw and see what happens!
 // Try changing how quickly the value of degree changes every time through draw and see what happens!
}

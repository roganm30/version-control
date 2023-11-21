int playerX, playerY; // Current Player position
int playerSize = 30; // Player size

int obstacleX, obstacleY; // Obstacle position
int obstacleSize = 40; // Obstacle size
float obstacleSpeed = 5; // Obstacle falling speed

boolean gameStarted = false; // Capable of tracking if the game has started or not
int score = 0; // Starting score
float diffFactor = 0.5; // Factor to increase difficulty (obstacle speed)

void setup() {
  size(400, 400);
  noStroke();
  playerX = width / 2;
  playerY = height - 50;
  obstacleX = (int) random(width);
  obstacleY = 0;
}

void draw() {
  background(#AAEFF7);
  
  if (!gameStarted) {
    // Draw starting menu
    fill(0);
    textSize(32);
    textAlign(CENTER, CENTER);
    text("Press Space to Start", width / 2, height / 2);
  } else {
    // Draw player
    fill(0, 0, 255); // Blue color
    ellipse(playerX, playerY, playerSize, playerSize);
    
    // Draw obstacle
    fill(255, 0, 0); // Red color
    ellipse(obstacleX, obstacleY, obstacleSize, obstacleSize);
    
    // Draw floor
    fill (#5A9060);
    rect(0, 350, 400, 400);
    
    // Move player with arrow keys
    if (keyPressed) {
      if (keyCode == LEFT && playerX - playerSize / 2 > 0) {
        playerX -= 5;
      } else if (keyCode == RIGHT && playerX + playerSize / 2 < width) {
        playerX += 5;
      }
    }
    
    // Move player with wasd
    if (keyPressed) {
      if (key == 'a' && playerX - playerSize / 2 > 0) {
        playerX -= 5;
      } else if (key == 'd' && playerX + playerSize / 2 < width) {
        playerX += 5;
      }
    }
    
    // Move obstacle
    obstacleY += obstacleSpeed;
    
    // Check for collision
    if (dist(playerX, playerY, obstacleX, obstacleY) < playerSize / 2 + obstacleSize / 2) {
      // Game over
      fill(0);
      textSize(32);
      textAlign(CENTER, CENTER);
      text("Game Over! Score: " + score + "\nPress Space to Restart", width / 2, height / 2);
      noLoop(); // Stop the draw loop
    }
    
    // Reset obstacle and increase score if it goes off the screen
    if (obstacleY > height) {
      obstacleX = (int) random(width);
      obstacleY = 0;
      score++;
      // Increase difficulty over time
      obstacleSpeed += diffFactor;
    }
    
    // Display score
    fill(0);
    textSize(16);
    textAlign(LEFT, TOP);
    text("Score: " + score, 10, 10);
  }
}

void keyPressed() {
  if (keyCode == ' ' && !gameStarted) {
    // Start the game when space is pressed
    gameStarted = true;
    loop(); // Start the draw loop
  } else if (keyCode == ' ' && !looping) {
    // Restart the game when space is pressed after game over
    gameStarted = true;
    loop(); // Start the draw loop
    playerX = width / 2;
    playerY = height - 50;
    obstacleX = (int) random(width);
    obstacleY = 0;
    score = 0;
    obstacleSpeed = 5; // Reset obstacle falling speed
  }
}

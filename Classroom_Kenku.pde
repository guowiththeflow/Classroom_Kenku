import java.util.Map;
import g4p_controls.*;
PImage upper, lower;
String[] punctuation = {",", "\"", ".", "?", "!", ":", ";", "*", "(", ")"};
Teacher currTeacher;
String[] sentence = {};
ArrayList<String[]> sentenceByLines = new ArrayList<String[]>();
int startIndex = 0;
int numLines;

// Variables for text printing:
PFont monospace;
int maxCharsPerLine = 110;
int fontSize = 13;
int spaceBetweenLines = 4;
int currLine;

void setup() {
  Teacher araujo = new Teacher("Araujo", "Araujo Transcript.txt", "Araujo Upper Screenshot.png");
  Teacher bruzzese = new Teacher("Bruzzese", "Bruzzese Transcript.txt", "Bruzzese Upper Screenshot.png");
  Teacher schattman = new Teacher("Schattman", "Schattman Transcript.txt", "Schattman Upper Screenshot.png");
  Teacher scullion = new Teacher("Scullion", "Scullion Transcript.txt", "Scullion Upper Screenshot.png");
  
  currTeacher = schattman;
  currTeacher.buildVocabMap();
  //currTeacher.printVocabMap();
  currTeacher.spewGibberish(); // Deeply, deeply out of character.
  
  size(800, 600);
  lower = loadImage("Bottom Screenshot.png");
  monospace = createFont("MS Gothic", fontSize);
  textLeading(spaceBetweenLines);
  textFont(monospace);
}

void draw() {
  
  background(255);
  
  if(sentence.length % 121 != 0) // given that integer operations chop off the final decimal, always round up UNLESS the number of characters is an exact multiple of the max number of characters.
    numLines = join(sentence, " ").length()/maxCharsPerLine + 1;
  else
    numLines = join(sentence, " ").length()/maxCharsPerLine;
  
  upper = loadImage(currTeacher.upperScreenshot);
  int imgX = (width-upper.width)/2;
  int textBoxHeight = (fontSize+spaceBetweenLines)*numLines+20; // constant of 10 acts as a buffer between bottom screenshot and text
  int upperY = (height-textBoxHeight-upper.height-lower.height)/3; // text stays in the top portion of the screen, as the bottom portion contains the onscreen GUI with dynamic buttons
  
  stroke(220);
  fill(255);
  rect(imgX+1, upperY+upper.height-0.5, upper.width-4, textBoxHeight);
  image(upper, imgX, upperY);
  image(lower, imgX-1, upperY+upper.height+textBoxHeight-0.5); // constant of 0.5 allows the top border of the rectangle's outline sneak under the top screenshot :)
    
  fill(0);
  text(join(sentence, " "), imgX+20, upperY+upper.height+6, upper.width-45, textBoxHeight);
  
}
// === VOCAB BUILDER - DONE ===
// Read specified file in as one string (all lowercase), then split string up by spaces and let every substring between spaces be a new Word object; store these Words in an originalFileArray
// Word class contains:
// - The specific string that it represents, without spaces (String contents)
// - The number of characters in Word.contents
// - A Following-ArrayList of every Word that has been recorded to come after this.Word
// For every item in the originalFileArray:
// - Iterate through every object of an Everything-ArrayList with a for loop
// - If it matches a string of an already existing Word.contents:
// - - Do nothing
// - If it does not match:
// - - Create a new Word with the string as its contents
// - - Add the new Word to the Everything-ArrayList
// - Either way, add the Word thats contents match the current string to the end of the previous Word's Following-ArrayList (keep track with a variable)
// - Update the previous Word variable to match the current Word
// Repeat until the end of the string; to avoid going out of bounds, also add the very first word to the Following-ArrayList of the very last word, just in case the last word only appears once (ie wouldn't have anything following it).

// === DEMO - DONE ===
// Generate a random string (no user interaction) with Mr. Schattman's classroom posts:
// Pick a random length n from 5-15 words
// Pick any word from Everything-ArrayList as the starting word
// Repeat n-1 times:
// - Pick any word from Following-ArrayList

// === FINAL (W/ GUI) ===

// ON STARTUP:
// Default to Schattman

// START/RESET:
// Top screenshot is selected based on the current teacher
// White rectangle with height of fh and width of screenshot's width acts as a background for text
// Bottom screenshot remains consistent

// ON SCREEN GUI:
// Word buttons pick a random word from the current word's FollowingArray
// - If it matches a word that has already been chosen earlier in this three-word process, pick something else UNLESS there are less than three unique words in the array,
// - - In which case pick any random word from the Everything-ArrayList to act as a filler (still avoiding repeats)
// Once the three words have been located, update the button text and internal word to match

// Punctuation buttons never change; always print their matching punctuation

// When a word or punct is clicked:
// - If the number of characters exceeds the remaining number of characters allowed in the current line of text (ie 30 characters; measure based on font size and size of screenshot):
// - - If the current line is the last line (ie 5 lines max; measure based on font size and size of screen):
// - - - Output "Not enough room -- try clearing the board!" [TEXT DOES NOT GET PRINTED]
// - - Else:
// - - - Increase the size of the white background rectangle by fh (font height + small buffer)
// - - - Move the screenshot's "bottom half" down by fh
// - - - Switch text to print on the next line (ie move text down by fh)
// - - - Print the text onscreen in mono font
// - Else:
// - - Print the text onscreen in mono font and save that text to last

// SECOND WINDOW GUI:
// Buttons to choose which teacher; reset program when a new teacher is picked
// Button to randomly generate w/ demo code?
// Button to save screen as an image
// Trash can to clear the screen and reset

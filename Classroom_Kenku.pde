/* NOTE: As I spoke with you about on Monday, G4P appears to have run into a bug with Processing itself (as opposed to my own code). 

As such, I was unable to implement a GUI to accomplish all the features my project set out to do. Missing features are:
1. Saving and clearing the screen. (My clear function is already coded in the form of "reset()"; the save function would have simply saved the current main screen as an image.)
2. Varying the length of generated gibberish. (I would have done this with a slider that went from "short" to "long", and predetermined sentence lengths for each.)
3. Using dynamic buttons to build a sentence yourself, including punctuation.
(I would have done this by updating the face text and button variable with three random selections from the vocabMap's array based on the current word OR any random word from the 
vocab as a whole if there were less than 3 unique options, and then appending the button text to the end of the sentence array. Punctuation buttons would operate much the same,
except with no need to update dynamically as they would always represent the same character.)

The interactive GUI features I was able to add before G4P had its mental breakdown were:
1. Toggling between teachers.
2. Generating gibberish based on those teachers' vocabulary.

As the project stands, the teacher names and gibberish-generating buttons on the Teacher Selection GUI are still usable--just ugly and clearly incomplete.
Meanwhile, the Word Selection screen does nothing but get in the way. When we spoke on Monday, you gave me permission to hand in the project as-is without penalty.
If you'd like to try to run the program without a GUI altogether, you can do so by manually changing the currTeacher variable in setup() and then repeatedly running the program.

Thank you for your understanding!!
*/

import java.util.Map;
import g4p_controls.*;

// Variables for file reading and interpretation
String[] punctuation = {",", "\"", ".", "?", "!", ":", ";", "*", "(", ")"};
String[] sentence = {}; // though this may have been more intuitively suited for an arrayList, the join() function only works with arrays, so I found some workarounds!

// Variables for main window display/text printing:
PFont monospace;
PImage upper, lower;
int maxCharsPerLine = 110;
int fontSize = 13;
int spaceBetweenLines = 4;
int currLine;
int numLines;
String sentenceLength;

// Teachers:
Teacher currTeacher;
Teacher araujo = new Teacher("Araujo", "Araujo Transcript.txt", "Araujo Upper Screenshot.png");
Teacher bruzzese = new Teacher("Bruzzese", "Bruzzese Transcript.txt", "Bruzzese Upper Screenshot.png");
Teacher schattman = new Teacher("Schattman", "Schattman Transcript.txt", "Schattman Upper Screenshot.png");
Teacher scullion = new Teacher("Scullion", "Scullion Transcript.txt", "Scullion Upper Screenshot.png");

void setup() {
  
  // TO RUN THE PROGRAM WITHOUT GUI, TRY CHANGING THESE VARIABLES!
  currTeacher = schattman; // Options: araujo, bruzzese, schattman, scullion
  sentenceLength = "medium"; // Options: "short", "medium", "long", "soliloquy"
  
  //araujo.buildVocabMap();
  bruzzese.buildVocabMap();
  schattman.buildVocabMap();
  //scullion.buildVocabMap();
  
  //currTeacher.printVocabMap();
  currTeacher.spewGibberish(); // Deeply, deeply out of character.
  
  size(800, 600);
  lower = loadImage("Bottom Screenshot.png");
  monospace = createFont("MS Gothic", fontSize);
  textLeading(spaceBetweenLines);
  textFont(monospace);
  createGUI();
}

void draw() {
  
  background(255);
  
  if(sentence.length % 121 != 0) // given that integer operations chop off the final decimal, round up UNLESS the number of characters is an exact multiple of the max number of characters.
    numLines = join(sentence, " ").length()/maxCharsPerLine + 1;
  else
    numLines = join(sentence, " ").length()/maxCharsPerLine;
  
  upper = loadImage(currTeacher.upperScreenshot);
  int imgX = (width-upper.width)/2;
  int textBoxHeight = (fontSize+spaceBetweenLines)*numLines+20; // constant of 10 acts as a buffer between bottom screenshot and text
  int upperY = (height-textBoxHeight-upper.height-lower.height)/2;
  
  // draws top and bottom google classroom screenshots to screen
  stroke(220);
  fill(255);
  rect(imgX+1, upperY+upper.height-0.5, upper.width-4, textBoxHeight);
  image(upper, imgX, upperY);
  image(lower, imgX-1, upperY+upper.height+textBoxHeight-0.5); // constant of 0.5 allows the top border of the rectangle's outline sneak under the top screenshot :)
    
  // draws sentence to google classroom screenshot
  fill(0);
  text(join(sentence, " "), imgX+20, upperY+upper.height+6, upper.width-45, textBoxHeight);
  
}

void reset() {
  String[] emptySentence = {};
  sentence = emptySentence;
  println(sentence);
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

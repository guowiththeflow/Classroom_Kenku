import java.util.Map;
import g4p_controls.*;

void setup() {
  // Reads text from file and converts it into one all-lowercase string
  String[] transcriptByLines = loadStrings("Schattman Transcript.txt");
  String transcriptByString = join(transcriptByLines, " ").toLowerCase();
  String[] transcriptByWords = transcriptByString.split(" ");
  
  // Variables to keep track of whether a word has already been encountered
  String[] vocabulary = {}; 
  boolean alreadyInVocab;
  int next;
  
  HashMap<String, String[]> vocabMap = new HashMap<String, String[]>(); // The String is the key; the String[] array keeps track of every string following this one
  
  // === VOCAB BUILDER ===
  for (int i=0; i < transcriptByWords.length; i++) {
    alreadyInVocab = false;
    
    // For every word in the transcript but the final one, checks if current word has already been encountered
    for (int j=0; j < vocabulary.length; j++) { // indexOf() doesn't work because it only looks for a certain collection of characters; if i was looking for the word "if" and already had "l[if]e" registered, the program would think "if" was in there
      if ( vocabulary[j].equals(transcriptByWords[i]) )
        alreadyInVocab = true;
    }
    
    if (i == transcriptByWords.length-1) // Last word
      next = 0; // In case the last word in the transcript is also a unique word, the first word in the transcript is always appended to the end of its array to ensure every word has at least one other following it
    else
      next = i+1;
    
    // If it's a new word, create a new key and array for "following words"
    if (alreadyInVocab == false) {// if the word does not already have an array mapped to it, create the key now
        String[] followingArray = {transcriptByWords[next]};
        vocabMap.put(transcriptByWords[i], followingArray);
        vocabulary = append(vocabulary, transcriptByWords[i]);
      }
    
    // If the word already exists in the vocabulary, add the next "following word" to the pre-existing array
    else {
      String[] followingArray = vocabMap.get(transcriptByWords[i]);
      followingArray = append(followingArray, transcriptByWords[next]);
      vocabMap.put(transcriptByWords[i], followingArray);
    }
  }
  
  // *** FOR DEBUGGING: prints vocab and following lists to screen ***
  for (Map.Entry me : vocabMap.entrySet()) {
    print("\"" + me.getKey() + "\" is followed by: ");
    println(me.getValue());
  }
  
  //println("========================");
  ////randomMimic(schattman);
  
  //String randStart = transcriptByWords[int(random(transcriptByWords.length-1))];
  //String sentence = randStart;
  //for (int i=0; i < random(5, 15); i++) {
  //  String[] currOptions = vocabMap.get(randStart);
  //  printArray(currOptions);
  //  String randNext = currOptions[int(random(currOptions.length-1))];
  //  sentence += " " + randNext;
  //}
  //println(sentence);
  
  
  
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

// === DEMO ===
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

  exit();
}

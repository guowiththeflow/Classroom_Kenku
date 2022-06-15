class Teacher {
  // === FIELDS ===
  // Basic variables, to be referenced elsewhere in the program
  String name;
  String transcript;
  String upperScreenshot;
  HashMap<String, String[]> vocabMap;
  
  // Variables for file-to-string conversion
  String[] transcriptByLines;
  String transcriptByString;
  String[] transcriptByWords;
  String[] finalTranscript = {};
  
  // Variables for vocab building
  String[] vocabulary = {}; 
  boolean alreadyInVocab;
  int nextIndex;
 
  
  // === CONSTRUCTOR ===
  Teacher(String n, String t, String us) {
    this.name = n;
    this.transcript = t;
    this.upperScreenshot = us;
  }
  
  
  // === METHODS ===
  
  // BUILD VOCAB MAP
  HashMap<String, String[]> buildVocabMap() {
    
    vocabMap = new HashMap<String, String[]>();
    
    // Reads text from file and converts it to an array with stripped-down words
    transcriptByLines = loadStrings(this.transcript);
    transcriptByString = join(transcriptByLines, " ").toLowerCase();
    transcriptByWords = transcriptByString.split(" ");
    
    for (int i=0; i < transcriptByWords.length; i++) {
      String w = transcriptByWords[i];
      
      // Remove punctuation at the end of a word
      for (int j=0; j < punctuation.length; j++)
        if (w.substring(w.length()-1).equals(punctuation[j]))
          w = w.substring(0, w.length()-1);
        
      // Remove punctuation at the beginning of a word
      for (int j=0; j < punctuation.length; j++)
        if (str(w.charAt(0)).equals(punctuation[j]))
          w = w.substring(1);
          
      finalTranscript = append(finalTranscript, w);
    }
      
    for (int i=0; i < finalTranscript.length; i++) {
      alreadyInVocab = false;
    
      // For every word in the transcript but the final one, checks if current word has already been encountered
      for (int j=0; j < vocabulary.length; j++) { // indexOf() doesn't work because it only looks for a certain collection of characters; if i was looking for the word "if" and already had "l[if]e" registered, the program would think "if" was in there
        if ( vocabulary[j].equals(finalTranscript[i]) )
          alreadyInVocab = true;
      }
      
      if (i == finalTranscript.length-1) // Last word
        nextIndex = 0; // In case the last word in the transcript is also a unique word, the first word in the transcript is always appended to the end of its array to ensure every word has at least one other following it
      else
        nextIndex = i+1;
      
      // If it's a new word, create a new key and array for "following words"
      if (alreadyInVocab == false) {// if the word does not already have an array mapped to it, create the key now
          String[] followingArray = {finalTranscript[nextIndex]};
          vocabMap.put(finalTranscript[i], followingArray);
          vocabulary = append(vocabulary, finalTranscript[i]);
        }
      
      // If the word already exists in the vocabulary, add the next "following word" to the pre-existing array
      else {
        String[] followingArray = vocabMap.get(finalTranscript[i]);
        followingArray = append(followingArray, finalTranscript[nextIndex]);
        vocabMap.put(finalTranscript[i], followingArray);
      }
    }
    
    return this.vocabMap;
  }
  
  // PRINT VOCAB
  void printVocabMap() {
    for (Map.Entry me : vocabMap.entrySet()) {
    print("\"" + me.getKey() + "\" is followed by: ");
    println(me.getValue());
    }
  println();
  }
  
  // GENERATE GIBBERISH
  void spewGibberish() {
    String sentence = "";
    float sentenceLength = random(15,30);
    String randNext = transcriptByWords[int(random(finalTranscript.length-1))];
    for (int i=0; i < sentenceLength; i++) {
      sentence += randNext + " ";
      String[] currOptions = vocabMap.get(randNext);
      // printArray(currOptions);
      randNext = currOptions[int(random(currOptions.length-1))];
    }
    println(this.name.toUpperCase(), "SEZ:", sentence);
  }
  
  
  
}

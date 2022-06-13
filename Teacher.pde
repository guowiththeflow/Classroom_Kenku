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
    
    transcriptByLines = loadStrings(this.transcript);
    transcriptByString = join(transcriptByLines, " ").toLowerCase();
    transcriptByWords = transcriptByString.split(" ");
    
    for (int i=0; i < transcriptByWords.length; i++) {
    alreadyInVocab = false;
    
      // For every word in the transcript but the final one, checks if current word has already been encountered
      for (int j=0; j < vocabulary.length; j++) { // indexOf() doesn't work because it only looks for a certain collection of characters; if i was looking for the word "if" and already had "l[if]e" registered, the program would think "if" was in there
        if ( vocabulary[j].equals(transcriptByWords[i]) )
          alreadyInVocab = true;
      }
      
      if (i == transcriptByWords.length-1) // Last word
        nextIndex = 0; // In case the last word in the transcript is also a unique word, the first word in the transcript is always appended to the end of its array to ensure every word has at least one other following it
      else
        nextIndex = i+1;
      
      // If it's a new word, create a new key and array for "following words"
      if (alreadyInVocab == false) {// if the word does not already have an array mapped to it, create the key now
          String[] followingArray = {transcriptByWords[nextIndex]};
          vocabMap.put(transcriptByWords[i], followingArray);
          vocabulary = append(vocabulary, transcriptByWords[i]);
        }
      
      // If the word already exists in the vocabulary, add the next "following word" to the pre-existing array
      else {
        String[] followingArray = vocabMap.get(transcriptByWords[i]);
        followingArray = append(followingArray, transcriptByWords[nextIndex]);
        vocabMap.put(transcriptByWords[i], followingArray);
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
  }
  
  // GENERATE GIBBERISH
  void spewGibberish() {
    String sentence = "";
    float sentenceLength = random(15,30);
    String randNext = transcriptByWords[int(random(transcriptByWords.length-1))];
    for (int i=0; i < sentenceLength; i++) {
      sentence += randNext + " ";
      String[] currOptions = vocabMap.get(randNext);
      // printArray(currOptions);
      randNext = currOptions[int(random(currOptions.length-1))];
    }
    println("SCHATTMAN SEZ: " + sentence);
  }
  
}

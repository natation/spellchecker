# Spellchecker

## Description
  ### This is a Ruby program (spellchecker.rb) that reads in a dictionary file of
  English words (dictionary.txt) and prompts the user to input a word.
  It will then either:
  
    * say that's the right spelling
    * suggest a correct spelling
    * or show NO SUGGESTION
  In addition there is another Ruby program (spelling_error_gen.rb)
  to generate some misspelled words so you can pipe this output into spellchecker.rb.

## How to Run
  * Make sure you have ruby installed on your machine and go to the terminal
  * For user input type: **ruby spellchecker.rb**
  * For spelling error generator type: **ruby spelling_error_gen.rb | ruby spellchecker.rb**

## Code
  I use a Trie data structure to reuse common letter nodes and use Levenshtein
  edit distance to calculate costs (excluding swapping) and give the suggested spelling result.

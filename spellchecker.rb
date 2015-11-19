DICTIONARY = "dictionary.txt"
MAX_COST = 4

def start(piped = false)
  trie_root = TrieNode.new
  dictionary = File.readlines(DICTIONARY)
  dictionary.each { |word| trie_root.insert(word.chomp) }
  if piped
    inputs = []
    spellchecked = []
    ARGF.each do |line|
      word = line.chomp
      modified_word = word.downcase
      inputs << word
      spellchecked << parse_search(trie_root.search(modified_word), word, piped)
    end
    puts "input: #{inputs.to_s}"
    puts
    puts "results: #{spellchecked.to_s}"
  else
    while true
      puts "Type in a word and press enter:"
      print "> "
      word = gets.chomp
      modified_word = word.downcase
      parse_search(trie_root.search(modified_word), word)
      puts
    end
  end
end

def parse_search(results, word, piped = false)
  result = ""
  results = results.delete_if { |result| result.first[0] != word[0].downcase }
  results = results.sort_by { |result| result.last }
  if results.empty?
    result = "NO SUGGESTION"
  elsif results.first[0] == word
    result = "You have great spelling!"
  else
    if piped
      result = results.first[0]
    else
      result = "Suggested spelling: #{results.first[0]}" unless results.empty?
    end
  end
  puts result unless piped
  result
end

class TrieNode
  attr_accessor :word, :children

  def initialize
    @word = nil
    @children = {}
  end

  def insert(word)
    node = self
    word.length.times do |i|
      letter = word[i]
      node.children[letter] = TrieNode.new unless node.children.include?(letter)
      node = node.children[letter]
    end
    node.word = word
  end

  def search(word)
    results = []
    current_row = (0..word.length).to_a
    self.children.each do |letter, node|
      search_trie_node(node, letter, word, current_row, results)
    end
    results
  end

  def search_trie_node(node, letter, word, previous_row, results)
    current_row = [previous_row.first + 1]
    num_cols = word.length
    1.upto(num_cols) do |col|
      sub_cost = word[col - 1] == letter ?
                                  previous_row[col - 1] :
                                  previous_row[col - 1] + 1
      insert_cost = current_row[col - 1] + 1
      delete_cost = previous_row[col] + 1
      min_cost = [sub_cost, insert_cost, delete_cost].min
      current_row << min_cost
    end
    if current_row.last <= MAX_COST && !node.word.nil?
      results << [node.word, current_row.last]
    end
    if current_row.min <= MAX_COST
      node.children.each do |letter, node|
        search_trie_node(node, letter, word, current_row, results)
      end
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  if STDIN.tty?
    start
  else
    start(true)
  end
end

# $ ruby words_to_terms.rb > dict_terms.pl
words = File.read('dict_words.txt').split
terms = words.map {|w| "word(#{w})."}
puts terms.join "\n"

# $ ruby words_to_terms.rb > dict_terms.txt
terms = File.read('dict.txt').split.map {|w| "word(#{w})."}.join "\n"
puts terms

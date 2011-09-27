f = File.read('dict.txt').split.map {|w| "word(#{w})."}.join "\n"
puts f

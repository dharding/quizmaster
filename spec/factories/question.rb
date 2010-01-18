Factory.define :question do |f|
  f.ask "What is your favorite color?"
  f.answer "Blue"
  f.difficulty {|o| Question::DIFFICULTIES.rand[1]}
end
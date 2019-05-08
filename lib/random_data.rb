module RandomData

  def self.random_sentence
    strings = []
    rand(3..5).times do
      strings << random_word
    end

    sentence = strings.join(" ")
    sentence.capitalize << "."
  end

  def self.random_word
    letters = ("a".."z").to_a
    letters.shuffle!
    letters[0, rand(3..8)].join
  end

  def self.random_year
    rand(1950..2050)
  end

  def self.random_scoring
    scoring_array = [
      "classic",
      "dixieland",
      "modern",
      "modified classic"
    ]
    scoring_array[rand(0...3)]
  end

  def self.random_style
    styles = [
      "Anonymous",
      "Gunboat",
      "Random",
      "Selected"
    ]
    styles[rand(0...3)]
  end

end

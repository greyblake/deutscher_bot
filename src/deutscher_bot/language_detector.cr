module DeutscherBot
  class LanguageDetector
    def initialize(text : String)
      @text = text
    end

    def detect : String
      if ru_score > de_score
        "ru"
      else
        "de"
      end
    end

    def de_score : Int
      calculate_score(DE_CHARS)
    end

    def ru_score : Int
      calculate_score(RU_CHARS)
    end

    private def calculate_score(chars)
      score = 0
      @text.each_char do |char|
        score += 1 if chars.includes?(char)
      end
      score
    end
  end
end

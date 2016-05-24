module DeutscherBot
  class Querier
    def initialize
      @glosbe = Glosbe::Client.new
      @google_translate = GoogleTranslate::Client.new
    end

    def lookup(query) : Response
      query = sanitize(query)

      source_lang, target_lang = detect_langs(query)
      query = Delemma.lemmatize(query) if source_lang == "de"

      gt_response = @google_translate.translate(source_lang, target_lang, query)
      glosbe_response = @glosbe.translate(source_lang, target_lang, query, true)
      build_response(gt_response, glosbe_response)
    end

    def sanitize(query : String)
      out = ""
      query.each_char do |char|
        out += char if VALID_CHARS.includes?(char)
      end
      out.strip
    end

    private def detect_langs(query)
      lang = LanguageDetector.new(query).detect
      case lang
      when "de"
        {"de", "ru"}
      when "ru"
        {"ru", "de"}
      else
        raise("Unknown language (DeutscherBot::Handler): #{lang}")
      end
    end

    private def build_response(gt_response, glosbe_response) : Response
      translations = [gt_response.text]
      gt_response.variants.each do |word_class, words|
        translations += words
      end

      good_glosbe_examples = find_good_examples(glosbe_response.examples).first(3)

      examples = good_glosbe_examples.map do |example|
        {example.first, example.second }
      end

      Response.new(
        gt_response.corrected_query,
        translations.uniq,
        examples
      )
    end

    private def find_good_examples(examples)
      examples.select { |ex| good_example?(ex) }
    end

    private def good_example?(example)
      return false if example.first.nil?

      doc = XML.parse_html(example.first)
      length = doc.text.try(&.size)
      return false if length.nil?

      15 < length < 70
    end
  end
end

module DeutscherBot
  class ReplyBuilder
    def initialize(@response : Response)
    end

    def build
      return "Ничего не найдено :(" if @response.translations.empty?

      out = ""
      out += "<b>#{@response.query}</b>\n"
      out += @response.translations.join("; ") + "\n\n"

      @response.examples.each do |pair|
        ex1, ex2 = pair
        out += ex1.strip + "\n"
        out += ex2.strip + "\n\n"
      end

      out.strip
    end

    def examples
      @response.examples.select { |ex| good_example?(ex) }
    end
  end
end

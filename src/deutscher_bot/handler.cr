module DeutscherBot
  class Handler
    def initialize
      @querier = Querier.new
    end

    def handle(text)
      return "Эй! Я понимаю только печатными буквами." if text.nil?
      lookup(text)
    end

    private def lookup(text : String)
      response = @querier.lookup(text.strip)
      reply = ReplyBuilder.new(response).build
      reply
    end
  end
end

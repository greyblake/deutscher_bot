module DeutscherBot
  class Handler
    HELP_MESSAGE = <<-STR
    Привет! Я был создан, чтобы помочь тебе учить немецкий язык!

    Вот, что я могу:
      - Находить переводы слов;
      - Находить примеры использования слов;
      - Переводит фразы.

    Просто напиши или перешли мне сообщение на русском или немецком, и я попробую перевести его.

    Я был создан @greyblake. Мой исходный код написан на языке прогроммирования Crystal, и он находится в открытом доступе: https://github.com/greyblake/deutscher_bot

    Viel Spaß mit Deutsch!
    STR

    def initialize
      @querier = Querier.new
    end

    def handle(text)
      return "Эй! Я понимаю только печатными буквами." if text.nil?
      text = text.strip

      case text
      when "/start", "/help" then HELP_MESSAGE
      else
        lookup(text)
      end
    end

    private def lookup(text : String)
      response = @querier.lookup(text.strip)
      reply = ReplyBuilder.new(response).build
      reply
    end
  end
end

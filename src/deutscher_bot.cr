require "xml"

require "delemma"
require "glosbe"
require "telegram_bot"
require "google_translate"

require "./deutscher_bot/*"

module DeutscherBot
  RU_CHARS = %w(А а Б б В в Г г Д д Е е Ё ё Ж ж З з И и Й й К к Л л М м Н н О о П п Р р С с Т т У у Ф ф Х х Ц ц Ч ч Ш ш Щ щ Ъ ъ Ы ы Ь ь Э э Ю ю Я я).map {|str| str[0]}
  DE_CHARS = %w(a A b B c C d D e E f F g G h H i I j J k K l L m M n N o O p P q Q r R s S t T u U v V w W x X y Y z Z Ä ä Ö ö Ü ü ß).map {|str| str[0]}

  # Used to sanitize messages
  VALID_CHARS = RU_CHARS + DE_CHARS + [' ', ',', '.', '-', '?', '!', '/', '=', ':', ')', '(', '0', '1','2', '3', '4', '5', '6', '7', '8', '9']
end

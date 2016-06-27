require "../src/deutscher_bot"

if ENV["TOKEN"]?
  token = ENV["TOKEN"]
else
  abort "Please set TOKEN env variable"
end

handler = DeutscherBot::Handler.new

puts "Started ..."
TelegramBot::Bot.new(token).run do |message|
  answer = handler.handle(message.text)
  message.reply(answer)
end

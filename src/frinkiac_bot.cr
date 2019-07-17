require "crystal-slack"
require "./commands/*"

module FrinkiacBot
  app = App.singleton
  bot = Bot.new(ENV["BOT_TOKEN"])


  meme_command = SimpsonsMemeCommand.new(
    bot,
    CommandType::HEAR,
    "/simpsons meme me (.+)/"
  )
  image_command = SimpsonsImageCommand.new(
    bot,
    CommandType::HEAR,
    "/simpsons image me (.+)/"
  )

  app.add_command(meme_command)
  app.add_command(image_command)

  app.add_bot(bot)
  app.run_app_server


end

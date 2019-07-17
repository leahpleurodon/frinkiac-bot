require "crystal-slack"
require "./commands/*"

module FrinkiacBot
  app = App.singleton
  bot = Bot.new(ENV["BOT_TOKEN"])


  meme_command = SimpsonsMemeCommand.new(
    bot,
    CommandType::DEMAND,
    "simpsons meme me (.+)"
  )
  image_command = SimpsonsImageCommand.new(
    bot,
    CommandType::DEMAND,
    "simpsons image me (.+)"
  )
  about_command = AboutCommand.new(
    bot,
    CommandType::DEMAND,
    "about"
  )

  app.add_command(meme_command)
  app.add_command(image_command)
  app.add_command(about_command)

  app.add_bot(bot)
  app.run_app_server


end

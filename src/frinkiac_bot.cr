require "crystal-slack"
require "./commands/*"

module FrinkiacBot
  app = App.singleton
  bot = Bot.new(ENV["BOT_TOKEN"])
  
  app.add_command(
    SimpsonsMemeCommand.new(
      bot,
      CommandType::DEMAND,
      "/simpsons meme me (.+)/"
    )
  )

  app.add_command(
    SimpsonsImageCommand.new(
      bot,
      CommandType::DEMAND,
      "/simpsons image me (.+)/"
    )
  )

  app.add_bot(bot)
  app.run_app_server


end

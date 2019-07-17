require "crystal-slack"
require "../frinkiac/frinkiac_service"

class SimpsonsMemeCommand < Command
    def call(event : Slack::Api::Event)
        query= event.event_text.sub /.+simpsons meme me /, ""
        App.singleton.logger.info("sending frinkiac api query: #{query}")
        Response.new(
            text: FrinkiacService.get_meme_with_captions(query),
            channel: event.event_channel,
            bot: @bot,
            timestamp: "0"
        ).post!
    end
end
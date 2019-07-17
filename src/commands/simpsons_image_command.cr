require "crystal-slack"
require "../frinkiac/frinkiac_service"

class SimpsonsImageCommand < Command
    def call(event : Slack::Api::Event)
        query= event.event_text.sub /.+simpsons image me /, ""
        App.singleton.logger.info("sending frinkiac api query: #{query}")
        Response.new(
            text: FrinkiacService.get_meme_no_captions(query),
            channel: event.event_channel,
            bot: @bot,
            timestamp: "0"
        ).post!
    end
end
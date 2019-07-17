require "crystal-slack"
require "../frinkiac/frinkiac_service"

class AboutCommand < Command
    def call(event : Slack::Api::Event)
        App.singleton.logger.info("about command invoked")
        Response.new(
            text: "Frinkiac bot written using Frinkiac API by leahpleurodon... please dont tell people i live this way",
            channel: event.event_channel,
            bot: @bot,
            timestamp: "0"
        ).post!
    end
end
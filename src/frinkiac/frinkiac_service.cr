require "http/client"
require "crystal-slack"
require "crest"
require "json"
require "base64"

class FrinkiacService 

    def self.get_meme_with_captions(query : String) : String
        search_results = episode_time_stamp(query)
        episode = search_results["Episode"].as_s
        time_stamp = search_results["Timestamp"].as_i
        b64_captions = formatted_captions(episode, time_stamp)
        "https://frinkiac.com/meme/#{episode}/#{time_stamp}?b64lines=#{b64_captions}"
    end

    def self.get_meme_no_captions(query : String) : String
        search_results = episode_time_stamp(query)
        episode = search_results["Episode"].as_s
        time_stamp = search_results["Timestamp"].as_i
        "https://frinkiac.com/meme/#{episode}/#{time_stamp}"
    end

    private def self.episode_time_stamp(query : String) : JSON::Any
        url_safe_query= URI.escape(query)
        url = "https://frinkiac.com/api/search?q=#{url_safe_query}"
        App.singleton.logger.info("sending query: #{url}")
        results = Crest.get(url)
        JSON.parse(results.body)[0]
    end

    private def self.formatted_captions(episode : String, time_stamp : Int32)
        results = Crest.get(
            "https://frinkiac.com/api/caption?e=#{episode}&t=#{time_stamp}"
        )
        captions = JSON.parse(results.body)["Subtitles"].as_a.flat_map{ |i|
            i["Content"].as_s.strip
        }.join(" ").strip
        Base64.urlsafe_encode(caption_wrap(captions))
    end

    private def self.caption_wrap(captions : String)
        return captions if captions.size < 20
        words = captions.split(/(.{1,20}\b)/)
        words.select{|w| !w.empty?}
            .map{|w| w.strip}
            .join("\n")
    end

end

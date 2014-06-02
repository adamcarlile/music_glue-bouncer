# define Heroku and Heroku::Bouncer
module MusicGlue
  class Bouncer
    def self.new(*args)
      MusicGlue::Bouncer::Builder.new(*args)
    end
  end
end

require 'music_glue/bouncer/builder'

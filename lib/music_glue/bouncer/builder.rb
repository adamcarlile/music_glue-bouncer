require 'music_glue/bouncer/middleware'
require 'rack/builder'
require 'omniauth-music_glue'

class MusicGlue::Bouncer::Builder

  def self.new(app, options = {})
    builder = Rack::Builder.new
    id, secret, scope = extract_options!(options)
    unless options[:disabled]
      builder.use OmniAuth::Builder do
        provider :music_glue, id, secret, :scope => scope
      end
    end
    builder.run MusicGlue::Bouncer::Middleware.new(app, options)
    builder
  end

  def self.extract_options!(options)
    oauth = options[:oauth] || {}
    id = oauth[:id]
    secret = oauth[:secret]
    scope = oauth[:scope] || 'identity'

    if id.nil? && ENV.has_key?('MUSIC_GLUE_OAUTH_ID')
      $stderr.puts "[warn] music_glue-bouncer: MUSIC_GLUE_OAUTH_ID detected in environment, please pass in :oauth hash instead"
      id = ENV['MUSIC_GLUE_OAUTH_ID']
    end

    if secret.nil? && ENV.has_key?('MUSIC_GLUE_OAUTH_SECRET')
      $stderr.puts "[warn] music_glue-bouncer: MUSIC_GLUE_OAUTH_SECRET detected in environment, please pass in :oauth hash instead"
      secret = ENV['MUSIC_GLUE_OAUTH_SECRET']
    end

    if id.nil? || secret.nil? || id.empty? || secret.empty?
      $stderr.puts "[fatal] music_glue-bouncer: OAuth ID or secret not set, middleware disabled"
      options[:disabled] = true
    end

    # we have to do this here because we wont have id+secret later
    if options[:secret].nil?
      if ENV.has_key?('COOKIE_SECRET')
        $stderr.puts "[warn] music_glue-bouncer: COOKIE_SECRET detected in environment, please pass in :secret instead"
        options[:secret] = ENV['COOKIE_SECRET']
      else
        $stderr.puts "[warn] music_glue-bouncer: :secret is missing, using id + secret"
        options[:secret] = id.to_s + secret.to_s
      end
    end

    [id, secret, scope]
  end
end

require "digest/sha1"

class FSCacheMiddleware < Cossack::Middleware
  CACHE_PATH = "/tmp/deutscher_bot_cache"

  def initialize(app, @cache_path = CACHE_PATH)
    Dir.mkdir(@cache_path) unless Dir.exists?(@cache_path)
    super(app)
  end

  def call(request)
    return app.call(request) unless request.method == "GET"
    digest = Digest::SHA1.hexdigest(request.uri.to_s)
    file = File.join(@cache_path, digest)

    if File.exists?(file)
      body = File.read(file)
      Cossack::Response.new(200, body)
    else
      response = app.call(request)
      File.write(file, response.body) if response.success?
      response
    end
  end
end

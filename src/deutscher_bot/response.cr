module DeutscherBot
  class Response
    getter :query, :translations, :examples

    def initialize(@query : String, @translations : Array(String), @examples : Array(Tuple(String, String)))
    end
  end
end

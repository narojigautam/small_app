require "cuba"
require "cuba/safe"
require "mote"
require "mote/render"

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe
Cuba.plugin(Mote::Render)

Cuba.define do
  on get do
    on root do
      res.write view("index")
    end
  end
end

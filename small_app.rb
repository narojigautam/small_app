require "cuba"
require "cuba/safe"
require "mote"
require "mote/render"
currrent_dir = File.expand_path(File.dirname(__FILE__))
Dir[File.join(currrent_dir, "lib/*.rb"), File.join(currrent_dir, "lib/*/*.rb")].map { |file| require file }

Cuba.use Rack::Session::Cookie, :secret => "__a_very_long_string__"

Cuba.plugin Cuba::Safe
Cuba.plugin(Mote::Render)
Cuba.use Rack::Static,
  root: "public",
  urls: ["/js"]

Cuba.define do
  on get do
    on root do
      res.write view("index")
    end

    on "work_locations" do
      impactor = ImpacService.new
      work_locations = impactor.list_work_locations
      res.write work_locations.attributes.to_json
    end

    on "invoiced_customers" do
      impactor = ImpacService.new
      customers = impactor.list_invoiced_customers
      res.write customers.attributes.to_json
    end
  end
end

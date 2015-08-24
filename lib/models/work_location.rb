require 'virtus'

class WorkLocation
    include Virtus.model

    attribute :employee_count, Integer, default: 1
    attribute :id, String
    attribute :lat, Float, default: 18.5185442
    attribute :lon, Float, default: 73.9487664
end

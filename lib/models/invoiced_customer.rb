require 'virtus'

class InvoicedCustomer
    include Virtus.model

    attr_accessor :name, :id, :location, :total_invoiced, :country
    attribute :name, String
    attribute :id, String
    attribute :location, String
    attribute :total_invoiced, Float
    attribute :country, String
end

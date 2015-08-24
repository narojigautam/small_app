class BaseCollection < Array
    def attributes
		map{|collectible| collectible.attributes }
	end
end

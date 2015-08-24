class ImpacService < BaseService

	def list_work_locations
		work_locations = WorkLocations.new
		get_employee_details.each do |employee_details|
			employee_details["work_locations"].each do |workplace|
				location_id = work_locations.find_index {|loc| loc.id == workplace["id"]}
				if location_id.nil?
					work_locations << WorkLocation.new(id: workplace["id"])
	            else
	            	work_locations[location_id].employee_count += 1
	            end
            end
		end
		work_locations
	end

	def list_invoiced_customers
		customers = InvoicedCustomers.new
		get_customer_invoices.each do |customer_invoice|
			customers << InvoicedCustomer.new(name: customer_invoice["name"], id: customer_invoice["id"], 
				location: customer_invoice['address']['z'], 
				total_invoiced: customer_invoice["total_invoiced"], country: customer_invoice['address']['c'])
		end
		customers
	end

	private
	
	# {"gender":"M","social_security_number":"***-**-7896","hired_date":"2014-11-01",
	# "work_locations":[{"id":"711a8571-0b31-0133-4ced-22000aac0203"}],"created_at":"2015-07-13T02:04:46Z",
	# "updated_at":"2015-07-13T02:04:46Z","company_currency":"USD",
	# "address":"130 Elizabeth Street, Suite 130, San Francisco CA 94123, United States","email":null,
	# "phone":"012-345-6487","salary":{"for_period":"MONTHLY","currency":"USD","amount":6825.0},
	# "uid":"75975b00-0b31-0133-4cfd-22000aac0203","firstname":"Frank","lastname":"Boyer","dob":null,
	# "location":"-","supervisor":"-","employment_status":"-","note":"-"}
	def get_employees(options={})
		options.merge!({engine: 'hr/employees_list', 'metadata[organization_ids][]' => 'org-fbte'})
		get("/api/v1/get_widget", options)
	end

    # {"gender":"M","social_security_number":"***-**-7896","hired_date":"2014-11-01",
    # "work_locations":[{"id":"711a8571-0b31-0133-4ced-22000aac0203"}],"created_at":"2015-07-13T02:04:46Z",
    # "updated_at":"2015-07-13T02:04:46Z","company_currency":"USD",
    # "address":"130 Elizabeth Street, Suite 130, San Francisco CA 94123, United States","email":null,
    # "phone":"012-345-6487","salary":{"for_period":"MONTHLY","currency":"USD","amount":6825.0},
    # "uid":"75975b00-0b31-0133-4cfd-22000aac0203","firstname":"Frank","lastname":"Boyer","dob":null,
    # "location":"-","supervisor":"-","employment_status":"-","note":"-"}
	def get_employee_details(options={})
		options.merge!({engine: 'hr/employee_details', 'metadata[organization_ids][]' => 'org-fbte'})
		get("/api/v1/get_widget", options)["content"]["employees"]
	end

    # {"name":"ABC Furniture","id":"ffb009a1-05e5-0133-abe1-22000aac0203",
	# "address":{"s":"417 Lang Road","s2":"-","l":"-","r":"-","z":"-","c":"-"},"email":"info@abfl.com",
	# "phone":"-","website":"-","currency":"USD","contact":"Trish Rawlings","total_due":1388.0,"total_paid":0.0,
	# "total_invoiced":1388.0,"invoices":[{"uid":"161255f1-05ea-0133-afb3-22000aac0203","reference":"",
	# "transaction_no":"","invoice_date":"2015-04-20","due_date":"2015-05-05","status":"DRAFT","invoiced":388.0,
	# "due":388.0,"paid":0.0,"currency":"USD","tooltip_status":"due"},
	# {"uid":"085d45a1-05ea-0133-af9b-22000aac0203","reference":"","transaction_no":"710","invoice_date":"2015-03-12",
	# "due_date":"2015-03-12","status":"AUTHORISED","invoiced":1000.0,"due":1000.0,"paid":0.0,"currency":"USD",
	# "tooltip_status":"due"}]}
	def get_customer_invoices(options={})
		options.merge!({engine: 'invoices/list', 'metadata[organization_ids][]' => 'org-fbte', 'metadata[entity]' => 'customers | suppliers'})
		get("/api/v1/get_widget", options)["content"]["entities"]
	end
end

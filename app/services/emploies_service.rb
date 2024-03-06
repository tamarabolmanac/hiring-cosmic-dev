class EmploiesService
  def initialize
    @client = EmploiesClient.new
  end

  def import
    response = @client.get_data
    
    if response[:status] == 200
      emploies_raw_data = response[:data]
      
      emploies_raw_data.each do |employee_data|
        employee = create_new_employee(employee_data)
  
        employee.save! if employee.valid?
      end
    else
      Rails.logger.error("Error: The service wes not able to obtain the data. Message: #{response[:error]}")
    end
  end

  def create_new_employee(employee_data)
    Employee.create(
      external_id: employee_data["id"],
      date_of_birth: Date.parse(employee_data["date_of_birth"]),
      first_name: employee_data["first_name"],
      last_name: employee_data["last_name"],
      email: employee_data["email"],
      address: employee_data["address"],
      country: employee_data["country"],
      bio: employee_data["bio"].join(' '),
      rating: employee_data["rating"]
    )
  end
end
class EmploiesService
  def initialize(params)
    # TODO; adjust
    @params = params
  end

  def import
    get_token

    if @access_token
      emploies_raw_data = get_data

      emploies_raw_data.each do |employee_data|
        employee = Employee.create(
          external_id: employee_data["id"],
          date_of_birth: Date.parse(employee_data["date_of_birth"]),
          first_name: employee_data["first_name"],
          last_name: employee_data["last_name"],
          email: employee_data["email"],
          address: employee_data["address"],
          country: employee_data["country"],
          bio: employee_data["bio"],
          rating: employee_data["rating"]
        )
        # TODO check if valid
        employee.save!
      end
    end
  end

  def get_token
    request_body = 
      {
        grant_type: "password",
        client_id: "6779ef20e75817b79605",
        client_secret: "3e0f85f44b9ffbc87e90acf40d482602",
        username: "hiring",
        password: "tmtg"
      }
      
    # TODO Error handling and safe navigation
    response = RestClient.post 'https://beta.01cxhdz3a8jnmapv.com/api/v1/assignment/token/', request_body
    @access_token = JSON.parse(response.body)["access_token"]
  end

  def get_data
    headers = {
      Authorization: "Bearer #{@access_token}"
    }
    
    response = RestClient.get 'https://beta.01cxhdz3a8jnmapv.com/api/v1/assignment/employee/list', headers
    return JSON.parse(response.body)
  end
end
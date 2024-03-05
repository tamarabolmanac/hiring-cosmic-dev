class EmployeeDecorator <  Draper::Decorator
  def full_name
    [object.first_name, object.last_name].join(" ")
  end

  def date_of_birth
    object.date_of_birth.strftime("%m/%d/%Y")
  end
end
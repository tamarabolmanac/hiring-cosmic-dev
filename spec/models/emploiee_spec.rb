require 'rails_helper'

RSpec.describe Employee do
  describe "Validations" do
    let!(:employee) { create(:employee) }

    it "is not valid without a email" do
      employee.email = nil

      expect(employee.save).to be_falsey
    end

    it "is not valid without a first_name" do
      employee.first_name = nil

      expect(employee.save).to be_falsey
    end

    it "is not valid without a last_name" do
      employee.last_name = nil

      expect(employee.save).to be_falsey
    end
    
    it "is not valid without a date_of_birth" do
      employee.date_of_birth = nil

      expect(employee.save).to be_falsey
    end

    it "is not valid without a external_id" do
      employee.external_id = nil

      expect(employee.save).to be_falsey
    end

    it "is not valid without a address" do
      employee.address = nil

      expect(employee.save).to be_falsey
    end

    it "validates uniquness of external_id" do
      employee_unique = build(:employee, external_id: employee.external_id + "123")
      employee_same_external_id = build(:employee, external_id: employee.external_id)

      expect(employee_unique.save).to be_truthy
      expect(employee_same_external_id.save).to be_falsey
    end
  end
end

require 'rails_helper'

RSpec.describe EmploiesService, type: :service do
  describe "#import" do
    before do
      allow_any_instance_of(EmploiesClient).to receive(:get_token).and_return(lambda do
        "valid_token_simulation"
      end.call)

      allow_any_instance_of(EmploiesClient).to receive(:get_data).and_return(lambda do
        { status: 200, data: JSON.parse(File.read('spec/fixtures/employee_data.json')) }
      end.call)
    end

    it "creates new employee records" do
      EmploiesService.new.import

      expect(Employee.all.size).to eq 20
    end
  end
end


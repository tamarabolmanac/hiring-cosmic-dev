require 'rails_helper'

RSpec.describe EmploiesService, type: :service do
  describe "#import" do
    context "when retrieves the data from api" do
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

    context "when data retrival fail" do
      let(:logger_instance) { instance_double("Logger") }

      before do
        allow(Rails).to receive(:logger).and_return(logger_instance)

        allow_any_instance_of(EmploiesClient).to receive(:get_token).and_return(lambda do
          "valid_token_simulation"
        end.call)

        allow_any_instance_of(EmploiesClient).to receive(:get_data).and_return(lambda do
          { status: 500, error: "Internal server error: Unable to get the data" }
        end.call)
      end

      it "logs the error from server" do
        expect(logger_instance).to receive(:error).with("Error: The service wes not able to obtain the data. Message: Internal server error: Unable to get the data")
        EmploiesService.new.import
        
        expect(Employee.all.size).to eq 0
      end
    end
  end
end


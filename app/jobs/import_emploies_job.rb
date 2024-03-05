class ImportEmploiesJob < ApplicationJob
  queue_as :default

  def perform
    # Call service for import

    # Map the data
  end
end

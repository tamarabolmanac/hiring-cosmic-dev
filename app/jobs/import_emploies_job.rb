class ImportEmploiesJob < ApplicationJob
  queue_as :default

  def perform
    EmploiesService.new.import
  end
end

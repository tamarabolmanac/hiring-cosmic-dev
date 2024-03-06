class EmploiesController < ApplicationController
  def index
    @emploies = Employee.all.decorate
  end

  def import
    ImportEmploiesJob.perform_later

    redirect_to(request.referrer || root_path)
  end
end
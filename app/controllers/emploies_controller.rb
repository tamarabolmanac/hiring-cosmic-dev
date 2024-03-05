class EmploiesController < ApplicationController
  def index
    @emploies = Employee.all.decorate
  end
end
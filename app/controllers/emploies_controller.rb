class EmploiesController < ApplicationController
  def index
    @emploies = Employee.all
  end
end
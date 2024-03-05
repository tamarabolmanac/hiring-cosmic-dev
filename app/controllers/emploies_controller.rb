class EmploiesController < ApplicationController
  def index
    Employee.all
  end
end
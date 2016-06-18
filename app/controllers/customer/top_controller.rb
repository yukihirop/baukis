class Customer::TopController < ApplicationController

  def index
    raise Forbidden
    # raise ActiveRecord::RecordNotFound
    render action: 'index'
  end

end

class Admin::Base < ApplicationController

  private

  def current_administrator
    if session[:administrator_id]
      @current_administrator ||= Administrator.find_by(id: session[:administrator_id])
    end
  end

  # current_administratorを app/helpers/aplication_helper.rbに定義するのと同じ効果が得られます。
  helper_method :current_administrator

end

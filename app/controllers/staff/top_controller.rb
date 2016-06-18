class Staff::TopController < ApplicationController

  def index
    # 例外をわざと発生
    raise
    render action: 'index'
  end

end

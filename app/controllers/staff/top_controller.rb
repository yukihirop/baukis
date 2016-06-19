class Staff::TopController < Staff::Base

  def index
    # 例外をわざと発生
    # raise
    render action: 'index'
  end

end

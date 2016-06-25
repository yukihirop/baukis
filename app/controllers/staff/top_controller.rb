class Staff::TopController < Staff::Base
  skip_before_action :authorize

  def index
    # 例外をわざと発生
    # raise
    render action: 'index'
  end

end

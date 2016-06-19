class Admin::TopController < Admin::Base

  def index

    if current_administrator
      render action: 'dashboard'
    else
      render action: 'index'
    end

    # IpAddressRejectedのエラーをわざと発生
    # raise IpAddressRejected
    # render action: 'index'
  end

end

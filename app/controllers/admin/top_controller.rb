class Admin::TopController < Admin::Base

  def index

    # IpAddressRejectedのエラーをわざと発生
    # raise IpAddressRejected
    render action: 'index'
  end

end

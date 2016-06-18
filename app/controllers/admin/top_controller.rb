class Admin::TopController < ApplicationController

  def index

    # IpAddressRejectedのエラーをわざと発生
    raise IpAddressRejected
    render action: 'index'
  end

end

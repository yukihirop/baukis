class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # クロスサイトリクエストフォージェリー
  # 脆弱性を利用した攻撃方法のことです
  protect_from_forgery with: :exception

  # 任意のアクションで例外ActiveRecord::RecordnotFoundが発生した時に
  # アクションが中断され、メソッドrescue404が発生
  # rescue_from ActiveRecord::RecordNotFound, with: :rescue404

  # layoutの指定
  layout :set_layout

  #
  class Forbidden < ActionController::ActionControllerError;
  end
  class IpAddressRejected < ActionController::ActionControllerError;
  end

  # 例外が発生したら、例外を処理するメソッドrescue 500に任せる
  # rescue_from Exception, with: :rescue500
  # rescue_from Forbidden, with: :rescue403
  # rescue_from IpAddressRejected, with: :rescue403
  # rescue_from ActionController::RoutingError, with: :rescue404
  # rescue_from ActiveRecord::RecordNotFound, with: :rescue404


  # production環境でエラー処理
  include ErrorHandlers if Rails.env.production?

  private


  # コントローラ名を取得してlayoutを変えている
  def set_layout
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      'customer'
    end
  end

    # def rescue500(e)
    #   @exception = e
    #   render 'errors/internal_server_error', status: 500
    # end
    #
    # def rescue403(e)
    #   @exception = e
    #   render 'errors/forbidden', status: 403
    # end
    #
    # #
    # def rescue404(e)
    #   @exception = e
    #   render template: 'errors/not_found', status: 404
    # end

end

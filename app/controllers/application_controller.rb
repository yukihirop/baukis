class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # クロスサイトリクエストフォージェリー
  # 脆弱性を利用した攻撃方法のことです
  protect_from_forgery with: :exception

  layout :set_layout

  private

  # コントローラ名を取得してlayoutを変えている
  def set_layout
    if params[:controller].match(%r{\A(staff|admin|customer)/})
      Regexp.last_match[1]
    else
      'customer'
    end
  end

end

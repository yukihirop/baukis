class Admin::SessionsController < Admin::Base

  def new
    # すでにログインしている場合
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end

  def create

    @form = Admin::LoginForm.new(params[:admin_login_form])
    if @form.email.present?
      administrator = Administrator.find_by(email_for_index:@form.email.downcase)
    end

    # administratorがnilでなく認証されたらsessionに保存
    if Admin::Authenticator.new(administrator).authenticate(@form.password)
      session[:administrator_id] = administrator.id
      flash.notice = 'ログインしました。'
      redirect_to :admin_root
    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end

  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :admin_root
  end

end

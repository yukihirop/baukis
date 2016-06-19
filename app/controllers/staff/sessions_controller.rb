class Staff::SessionsController < Staff::Base

  def new
    # すでにログインしている場合
    if current_staff_member
      redirect_to :staff_root
    else
      @form = Staff::LoginForm.new
      render action: 'new'
    end
  end

  def create
    @form = Staff::LoginForm.new(params[:staff_login_form])
    if @form.email.present?
      staff_member = StaffMember.find_by(email_for_index: @form.email.downcase)
    end

    # staff_memaberがnilでないならsessionに保存
    if Staff::Authenticator.new(staff_member).authenticate(@form.password)
      session[:staff_member_id] = staff_member.id
      flash.notice = 'ログインしました。'
      # indexにredirect
      redirect_to :staff_root

    elsif !Staff::Authenticator.new(staff_member).suspended_authenticate(@form.password)
      flash.notice = 'アカウントが停止されています。'
      redirect_to :staff_root

    else
      flash.now.alert = 'メールアドレスまたはパスワードが正しくありません。'
      render action: 'new'
    end

  end

  def destroy
    session.delete(:staff_member_id)
    flash.notice = 'ログアウトしました。'
    redirect_to :staff_root
  end



end

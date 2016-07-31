module FeaturesSpecHelper
  def switch_namespace(namespace)
    config = Rails.application.config.baukis
    Capybara.app_host = 'http://' + config[namespace][:host]
  end

  def login_as_staff_member(staff_member, password = 'pw')
    visit staff_login_path
    within('#login-form') do
      fill_in 'メールアドレス', with: staff_member.email
      # fill_in 'staff_login_form_email', with: staff_member.email　id属性を指定
      # とも書ける
      fill_in 'パスワード', with: password
      # ラベル文字、またはボタン要素(input要素、button要素)を引数には指定する
      click_button 'ログイン'
    end
  end



end

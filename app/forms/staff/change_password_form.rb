class Staff::ChangePasswordForm
  include ActiveModel::Model

  # objectはStaffMemberのobject
  attr_accessor :object, :current_password, :new_password,
      :new_password_confirmation

  # 確認パスワードと一致する必要がある。
  # confirmationタイプのバリデーション
  validates :new_password, presence: true, confirmation: true

  # 組み込みバリデーション以外のバリデーションの場合
  validate do
    # 現在のパスワードが有効でなければ
    unless Staff::Authenticator.new(object).authenticate(current_password)
      errors.add(:current_password, :wrong)
    end
  end

  def save
    if valid?
      object.password = new_password

      # このためにinclude
      object.save!
    end

  end

end

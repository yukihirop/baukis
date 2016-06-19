class StaffMember < ActiveRecord::Base
  # コールバック処理(バリデーションの前に自動で登録してくれる)
  before_validation do
    self.email_for_index = email.downcase if email
  end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end



end

class StaffMember < ActiveRecord::Base
  # has_many :staff_events, dependent: :destroy
  has_many :events, class_name: 'StaffEvent', dependent: :destroy

  # コールバック処理(バリデーションの前に自動で登録してくれる)
  before_validation do
    self.email_for_index = email.downcase if email
  end

  def active?
    !suspended? && start_date <= Date.today &&
        (end_date.nil? || end_date > Date.today)
  end

  def password=(raw_password)
    if raw_password.kind_of?(String)
      self.hashed_password = BCrypt::Password.create(raw_password)
    elsif raw_password.nil?
      self.hashed_password = nil
    end
  end



end

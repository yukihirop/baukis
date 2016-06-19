class Staff::Authenticator

  def initialize(staff_member)
    @staff_member = staff_member
  end

  # suspendedがfalseならは条件の一つ
  def authenticate(raw_password)
    @staff_member &&
        !@staff_member.suspended? &&
        @staff_member.hashed_password &&
        @staff_member.start_date <= Date.today &&
        (@staff_member.end_date.nil? || @staff_member.end_date > Date.today) &&
        BCrypt::Password.new(@staff_member.hashed_password) == raw_password
  end

  # 演習問題9-4-1で使うauthenticate
  # passwordが正しくてもsuspendedされていたらfalseを返す
  def suspended_authenticate(raw_password)
    @staff_member &&
        @staff_member.hashed_password &&
        BCrypt::Password.new(@staff_member.hashed_password) == raw_password &&
        !@staff_member.suspended?
  end




end

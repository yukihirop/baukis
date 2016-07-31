class HomeAddress < Address

  # 空欄はダメ
  validates :postal_code, :prefecture, :city, :address1, presence: true
  # 空欄であるべき
  validates :company_name, :division_name, absence: true


end

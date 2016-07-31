class Staff::CustomerForm
  include ActiveModel::Model

  attr_accessor :customer
  delegate :persisted?, :save, to: :customer

  def initialize(customer = nil)
    @customer = customer
    @customer ||= Customer.new(gender: 'male')
    @customer.build_home_address unless @customer.home_address
    @customer.build_work_address unless @customer.work_address
  end

  # フォームから送信されたデータを受ける
  def assign_attributes(params = {})
    @params = params

    customer.assign_attributes(customer_params)
    customer.home_address.assign_attributes(home_address_params)
    customer.work_address.assign_attributes(work_address_params)

  end

  # この書き方ならcustomer.valid?でひっかかったらそれ以降なにも起きない
  # def valid?
  #   customer.valid? && customer.home_address.valid? && customer.work_address.valid?
  # end

  # def valid?
  #   # all?メソッドは全部真なら真を返す
  #   [ customer, customer.home_address, customer.work_address ].map(&:valid?).all?
  # end

  # def save
  #   # customerのバリデーションがクリアできないとsaveしないようにする
  #   if valid?
  #     # 全てが完了か取り消しかを保証する
  #     ActiveRecord::Base.transaction do
  #       # 感嘆符ありのsave!メソッドは感嘆符なしのsaveメソッドとは異なり、
  #       # 保存前に行われるバリデーションに失敗すると例外ActiveRecord::RecordInvalidを
  #       # 発生させます。(→if文などで事前にするようにすればよい)
  #       customer.save!
  #       customer.home_address.save!
  #       customer.work_address.save!
  #     end
  #   end
  # end

  # autosave: trueにしたため
  # 委譲させることで必要なし
  # def save
  #   customer.save
  # end

  private
  def customer_params
    @params.require(:customer).permit(
        :email, :password,
        :family_name, :given_name,
        :family_name_kana, :given_name_kana,
        :birthday, :gender
    )
  end


  def home_address_params
    @params.require(:home_address).permit(
        :postal_code, :prefecture, :city,
        :address1, :address2,
    )
  end


  def work_address_params
    @params.require(:work_address).permit(
        :postal_code, :prefecture, :city,
        :address1, :address2,
        :company_name, :division_name,
    )
  end

end

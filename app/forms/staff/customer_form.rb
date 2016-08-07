class Staff::CustomerForm
  include ActiveModel::Model

  attr_accessor :customer, :inputs_home_address, :inputs_work_address
  delegate :persisted?, :save, to: :customer

  def initialize(customer = nil)
    @customer = customer
    @customer ||= Customer.new(gender: 'male')
    (2 - @customer.personal_phones.size).times do
      @customer.personal_phones.build
    end
    self.inputs_home_address = @customer.home_address.present?
    self.inputs_work_address = @customer.work_address.present?
    @customer.build_home_address unless @customer.home_address
    @customer.build_work_address unless @customer.work_address

    (2-@customer.home_address.phones.size).times do
      @customer.home_address.phones.build
    end

    (2-@customer.work_address.phones.size).times do
      @customer.work_address.phones.build
    end

  end

  # フォームから送信されたデータを受ける
  def assign_attributes(params = {})
    @params = params

    self.inputs_home_address = params[:inputs_home_address] == '1'
    self.inputs_work_address = params[:inputs_work_address] == '1'

    customer.assign_attributes(customer_params)

    # fetch(キー)、キーの値を返す
    phones = phone_params(:customer).fetch(:phones)
    customer.personal_phones.size.times do |index|
      attributes = phones[index.to_s]
      if attributes && attributes[:number].present?
        customer.personal_phones[index].assign_attributes(attributes)
      else
        customer.personal_phones[index].mark_for_destruction
      end
    end

    #有効の時だけ実行していく。(自宅住所に関して)
    if inputs_home_address
      customer.home_address.assign_attributes(home_address_params)

      phones = phone_params(:home_address).fetch(:phones)
      customer.home_address.phones.size.times do |index|
        attributes = phones[index.to_s]
        if attributes && attributes[:number].present?
          customer.home_address.phones[index].assign_attributes(attributes)
        else
          customer.home_address.phones[index].mark_for_destruction
        end
      end

    else
      # 削除s対象という’印'をつけるメソッド、Customerオブジェクトが保存される前
      # に自動的にデータベースから削除されまる
      customer.home_address.mark_for_destruction
    end



    if inputs_work_address
      customer.work_address.assign_attributes(work_address_params)

      phones = phone_params(:work_address).fetch(:phones)
      customer.work_address.phones.size.times do |index|
        attributes = phones[index.to_s]
        if attributes && attributes[:number].present?
          customer.work_address.phones[index].assign_attributes(attributes)
        else
          customer.work_address.phones[index].mark_for_destruction
        end
      end

    else
      customer.work_address.mark_for_destruction
    end


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

  def phone_params(record_name)
    @params.require(record_name).permit(phones: [ :number, :primary])
  end

end

class Phone < ActiveRecord::Base

  include StringNormalizer

  belongs_to :customer
  belongs_to :address

  before_validation do
    self.number = normalize_as_phone_number(number)
    #number属性の値から数字以外の文字(正規表現では\D)をgsubメソッドで
    #すべて除去し、number_for_index属性にセット
    self.number_for_index = number.gsub(/\D/, '') if number

    if number_for_index && number_for_index.size >= 4
      self.last_four_digits = number_for_index[-4, 4]
    end
  end

  before_create do
    self.customer = address.customer if address
    # self.last_four_digits = address.number_for_index[-4,4]
  end

  # 先頭にプラス記号が０個か１個あり
  # 1個以上の数字が並び
  # マイナス記号１個と１個以上の数字という組み合わせが０個以上並んで
  # 末尾にいたる
  validates :number, presence: true,
      format: { with: /\A\+?\d+(-\d+)*\z/, allow_blank: true }





end

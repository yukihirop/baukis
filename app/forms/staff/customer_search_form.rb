class Staff::CustomerSearchForm

  include ActiveModel::Model
  include StringNormalizer

  attr_accessor :family_name_kana, :given_name_kana,
                :birth_year, :birth_month, :birth_mday,
                :address_type, :prefecture, :city, :phone_number,
                :gender,
                :postal_code,
                :last_four_digits

  def search
    normalize_values

    rel = Customer

    if family_name_kana.present?
      rel = rel.where(family_name_kana: family_name_kana)
    end

    if given_name_kana.present?
      rel = rel.where(given_name_kana: given_name_kana)
    end

    rel = rel.where(birth_year: birth_year) if birth_year.present?
    rel = rel.where(birth_month: birth_month) if birth_month.present?
    rel = rel.where(birth_mday: birth_mday) if birth_mday.present?

    if prefecture.present? || city.present?
      case address_type
        when 'home'
          rel = rel.joins(:home_address)
        when 'work'
          rel = rel.joins(:work_address)
        when ''
          rel = rel.joins(:addresses)
        else
          raise
      end

      if prefecture.present?
        # テーブル名.カラム名
        rel = rel.where('addresses.prefecture' => prefecture)
      end

      if city.present?
        rel = rel.where('addresses.city' => city)
      end

    end

    # フォームの電話番号フィールドに値が記入されていればphones
    # テーブルを結合した上で、phonesテーブルのnumber_for_indexカラム
    # に基づいて顧客を絞る
    if phone_number.present?
      rel = rel.joins(:phones).where('phones.number_for_index' => phone_number)
    end

    # 性別で検索できるようにする
    if gender.present?
      rel = rel.where(gender: gender)
    end

    # 郵便番号で検索ができるようにする
    if postal_code.present?
      case address_type
        when 'home'
          rel = rel.joins(:home_address)
        when 'work'
          rel = rel.joins(:work_address)
        when ''
          rel = rel.joins(:addresses)
        else
          raise
      end
      rel = rel.where('addresses.postal_code' => postal_code)
    end

    # 電話番号(もしくは下4桁)で検索できるようにする
    if phone_number.present? || last_four_digits.present?
      rel = rel.joins(:phones)
      if phone_number.present?
        rel = rel.where('phones.number_for_index' => phone_number)
      end
      if last_four_digits.present?
        rel = rel.where('phones.last_four_digits' => last_four_digits)
      end
    end


    rel.order(:family_name_kana, :given_name_kana)

  end

  private

  def normalize_values
    self.family_name_kana = normalize_as_furigana(family_name_kana)
    self.given_name_kana = normalize_as_furigana(given_name_kana)
    self.city = normalize_as_name(city)
    self.phone_number = normalize_as_phone_number(phone_number).try(:gsub, /\D/, '')
    self.postal_code = normalize_as_postal_code(postal_code).try(:gsub, /\D/, '')
  end

end




class AddressPresenter < ModelPresenter
  delegate :prefecture, :city, :address1, :address2,
           :company_name, :division_name, to: :object

  def postal_code
    #　最初３桁と後4桁に分割している
    if md = object.postal_code.match(/\A(\d{3})(\d{4})\Z/)
      md[1] + '-' + md[2]
    else
      object.postal_code
    end
  end








end
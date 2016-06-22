require 'rails_helper'
require 'spec_helper'

describe Admin::StaffMembersController do
  # attributes_forはFactoryGirlのメソッド
  # letは「メモ化されたヘルパーメソッド」
  # def params_hash
  #   @params_hash ||= attributes_for(:staff_memmber)
  # end
  # の形をしている
  let(:params_hash) { attributes_for(:staff_member) }

  describe '#create' do

    example '職員一覧ページにリダイレクト' do
      # 第一引数に指定されたメソッドに対して、第二引数に指定されたデータをPOSTで送信
      post :create, staff_member: params_hash
      expect(response).to redirect_to(admin_staff_members_url)
    end

    example '例外ActionController::ParameterMissingが発生' do
      # rescue_fromによる例外処理を無効にしてくれる
      bypass_rescue
      expect {post :create}.to raise_error(ActionController::ParameterMissing)
    end

  end

  describe '#update' do

    # メモ化されたヘルパーメソッド
    # このcreateもFactoryGirlのメソッド
    # 定義済みのファクトリーからStaffMemberのインスタンスを作成
    let(:staff_member) { create(:staff_member) }

    example 'suspendedフラグをセットする' do
      params_hash.merge!(suspended: true)
      patch :update, id: staff_member.id, staff_member: params_hash
      staff_member.reload
      # be_suspendedは述語マッチャー
      expect(staff_member).to be_suspended
    end

    example 'hashed_passwordの値は書き換え不可' do
      params_hash.delete(:password)
      params_hash.merge!(hashed_password: 'x')
      expect {
        patch :update, id: staff_member.id, staff_member: params_hash
      }.not_to change { staff_member.hashed_password.to_s }
    end

  end

end


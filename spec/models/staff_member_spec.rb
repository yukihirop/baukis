require 'rails_helper'
require 'spec_helper'

RSpec.describe StaffMember, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

describe StaffMember do
  describe '#password=' do

    example '文字列を与えると、hashed_passwrodは長さ60の文字になる' do
      member = StaffMember.new
      member.password = 'baukis'
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    example 'nilを与えると、hashed_passwordはnilになる' do
      member = StaffMember.new(hashed_password: 'x')
      member.password = nil
      expect(member.hashed_password).to be_nil
    end

  end
end

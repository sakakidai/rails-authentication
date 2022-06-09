require 'rails_helper'

RSpec.describe 'User', type: :model do
  describe 'バリデーションのテスト' do
    it 'ユーザのseed dataが10件あること' do
      expect(User.count).to eq 10;
    end
  end
end
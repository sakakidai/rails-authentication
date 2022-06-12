require 'rails_helper'

RSpec.describe 'User', type: :model do
  describe 'seed data' do
    it 'There are 10 seed data' do
      expect(User.count).to eq 10;
    end
  end

  describe 'validation' do
    describe 'name' do
      max_length = 30
      context 'is nil' do
        it 'have name validation error' do
          expected_error_messages = ["名前を入力してください"]
          user = build(:user, name: nil)
          user.save
          expect(user.errors.full_messages).to eq(expected_error_messages)
        end
      end
  
      context 'is 30 more than' do
        it 'have name validation error' do
          expected_error_messages = ["名前は30文字以内で入力してください"]
          name = "a" * (max_length + 1)
          user = build(:user, name: name)
          user.save
          expect(user.errors.full_messages).to eq(expected_error_messages)
        end
      end

      context 'is 31 less than' do
        it 'can save' do
          name = "a" * max_length
          user = build(:user, name: name)
          expect{ user.save }.to change{ User.count }.by(1)
        end
      end
    end

    describe 'email' do
      max_length = 255
      domain = "@example.com"
      context 'is nil' do
        it 'hava email validation error' do
          expected_error_messages = ["メールアドレスを入力してください"]
          user = build(:user, email: nil)
          user.save
          expect(user.errors.full_messages).to eq(expected_error_messages)
        end
      end

      context 'is 255 more than' do
        it 'have email validation error' do
          expected_error_messages = ["メールアドレスは#{max_length}文字以内で入力してください"]
          email = "a" * (max_length + 1 - domain.length) + domain
          user = build(:user, email: email)
          user.save
          expect(user.errors.full_messages).to eq(expected_error_messages)
        end
      end

      context 'is 256 less than' do
        it 'can save' do
          email = "a" * (max_length - domain.length) + domain
          user = build(:user, email: email)
          expect{ user.save }.to change{ User.count }.by(1)
        end
      end

      context 'format is correct' do
        it 'can save' do
          correct_format_emails = %w(
            A@A.com
            a-_@e-x.c-o_m.j_p
            a.a@ex.com
            a@e.co.js
            1.1@ex.com
            a.a+a@ex.com
          )
          correct_format_emails.each do |email|
            user = build(:user, email: email)
            expect{ user.save }.to change{ User.count }.by(1)
          end
        end
      end

      context 'format is wrong' do
        it 'have email validation error' do
          wrong_format_emails = %w(
            aaa
            a.ex.com
            メール@ex.com
            a~a@ex.com
            a@|.com
            a@ex.
            .a@ex.com
            a＠ex.com
            Ａ@ex.com
            a@?,com
            １@ex.com
            "a"@ex.com
            a@ex@co.jp
          )
          wrong_format_emails.each do |email|
            expected_error_messages = ["メールアドレスは不正な値です"]
            user = build(:user, email: email)
            user.save
            expect(user.errors.full_messages).to eq(expected_error_messages)
          end
        end
      end

      context 'user saved' do
        it 'changed to lowercase' do
          email = "USER@EXAMPLE.COM"
          user = build(:user, email: email)
          user.save
          expect(user.email).to eq(email.downcase)
        end
      end

      describe 'active user uniqueness' do
        email = "test@example.com"

        context "same email is not active" do
          it 'can save' do
            count = 3
            count.times do |n|
              expect{ create(:user, email: email, activated: false) }.to change{ User.count }.by(1)
            end
          end
        end

        context 'there is an same email active user' do
          it 'have email validation error' do
            expected_error_messages = ["メールアドレスはすでに存在します"]
            create(:user, email: email, activated: true)
            user = build(:user, email: email, activated: true)
            user.save
            expect(user.errors.full_messages).to eq(expected_error_messages)
          end
        end
      end
    end

    describe 'password' do
      min_length = 8
      max_length = 72

      context 'is nil' do
        it 'have password validation error' do
          expected_error_messages = ["パスワードを入力してください"]
          user = build(:user, password: nil)
          user.save
          expect(user.errors.full_messages).to eq(expected_error_messages)
        end
      end

      context 'is 8 less than' do
        it 'have password validation error' do
          expected_error_messages = ["パスワードは8文字以上で入力してください"]
          password = "a" * (min_length - 1)
          user = build(:user, password: password)
          user.save
          expect(user.errors.full_messages).to eq(expected_error_messages)
        end
      end

      context 'is 72 more than' do
        it 'have password validation error' do
          expected_error_messages = ["パスワードは72文字以内で入力してください"]
          password = "a" * (max_length + 1)
          user = build(:user, password: password)
          user.save
          expect(user.errors.full_messages).to eq(expected_error_messages)
        end
      end

      context 'is between from 8 to 72' do
        it 'can be saved of 8-character password' do
          password = "a" * min_length
          user = build(:user, password: password)
          expect(user.save).to be_truthy
        end

        it 'can be saved of 72-character password' do
          password = "a" * max_length
          user = build(:user, password: password)
          expect(user.save).to be_truthy
        end
      end

      context 'format is correct' do
        it 'can save' do
          correct_format_passwords = %w(
            pass---word
            ________
            12341234
            ____pass
            pass----
            PASSWORD
          )
          correct_format_passwords.each do |password|
            user = build(:user, password: password)
            expect{ user.save }.to change{ User.count }.by(1)
          end
        end
      end

      context 'format is wrong' do
        it 'have password validation error' do
          wrong_format_passwords = %w(
            pass/word
            pass.word
            |~=?+"a"
            １２３４５６７８
            ＡＢＣＤＥＦＧＨ
            password@
          )
          wrong_format_passwords.each do |password|
            expected_error_messages = ["パスワードは半角英数字•ﾊｲﾌﾝ•ｱﾝﾀﾞｰﾊﾞｰが使えます"]
            user = build(:user, password: password)
            user.save
            expect(user.errors.full_messages).to eq(expected_error_messages)
          end
        end
      end
    end
  end
end
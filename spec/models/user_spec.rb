require 'rails_helper'
RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    it "nicknameが空だと登録できない" do
      @user.nickname = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Nickname can't be blank"
    end

    it "emailが空では登録できない" do
      @user.email = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Email can't be blank"
    end

    it "passwordが空では登録できない" do
      @user.password = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Password can't be blank"
    end

    it "last_nameが空では登録できない" do
      @user.last_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name can't be blank"
    end

    it "first_nameが空では登録できない" do
      @user.first_name = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "First name can't be blank"
    end

    it "last_name_kanaが空では登録できない" do
      @user.last_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Last name kana can't be blank"
    end

    it "first_name_kanaが空では登録できない" do
      @user.first_name_kana = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "First name kana can't be blank"
    end

    it "birth_dateが空では登録できない" do
      @user.birth_date = ""
      @user.valid?
      expect(@user.errors.full_messages).to include "Birth date can't be blank"
    end

    it "passwordが6文字以上であれば登録できること" do
      @user.password = "a12345"
      @user.password_confirmation = "a12345"
      expect(@user).to be_valid
    end

    it "passwordが5文字以下であれば登録できないこと" do
      @user.password = "1234a"
      @user.password_confirmation = "1234a"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it "passwordとpassword_confirmationが不一致では登録できないこと" do
      @user.password = "123456"
      @user.password_confirmation = "1234567"
      @user.valid?
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it "重複したemailが存在する場合登録できないこと" do
      @user.save
      another_user = FactoryBot.build(:user, email: @user.email)
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end

    it 'passwordが半角英語のみを含んでいる場合は登録できないこと' do
      @user.password = 'aaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end

    it 'passwordが半角数字のみを含んでいる場合は登録できないこと' do
      @user.password = '0000000'
      @user.valid?
      expect(@user.errors.full_messages).to include("Password Include both letters and numbers")
    end

    it 'last_nameが、全角（漢字・ひらがな・カタカナ)でなければ登録できないこと' do
      @user.last_name = 'aaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name Full-width characters")
    end

    it 'first_nameが、全角（漢字・ひらがな・カタカナ)でなければ登録できないこと' do
      @user.first_name = 'aaaaaaa'
      @user.valid?
      expect(@user.errors.full_messages).to include("First name Full-width characters")
    end

    it 'last_name_kanaが全てカタカナでなければ登録できない' do
      @user.last_name_kana = "ああああ"
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana Full-width katakana characters")
    end

    it 'first_name_kanaが全てカタカナでなければ登録できない' do
      @user.first_name_kana = "ああああ"
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana Full-width katakana characters")
    end
  end
end
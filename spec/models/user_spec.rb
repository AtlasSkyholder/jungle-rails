require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'is the first example' do
      # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Rogers',
        email: 'bob@rogers.com',
        password: 'bobbeh',
        password_confirmation: 'bobbeh'
      )
      expect(@user.id).to be_present
    end
    it 'should throw an error if password and password confirmation fields do not match' do
      # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Rogers',
        email: 'bob@rogers.com',
        password: 'bobbeh',
        password_confirmation: 'bobbey'
      )
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it 'should throw an error if password and password length is less than 3' do
      # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Rogers',
        email: 'bob@rogers.com',
        password: 'bo',
        password_confirmation: 'bo'
      )
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 3 characters)")
    end
    it 'it should throw an error if email is blank' do
      # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Rogers',
        email: nil,
        password: 'bobbeh',
        password_confirmation: 'bobbeh'
      )
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it 'it should throw an error if email is not unique' do
      # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Rogers',
        email: 'bob@rogers.com',
        password: 'bobbeh',
        password_confirmation: 'bobbeh'
      )
      @user2= User.create(
        first_name: 'Sob',
        last_name: 'Rogers',
        email: 'BOB@roGeRs.COM',
        password: 'bobbeh',
        password_confirmation: 'bobbeh'
      )
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    it 'it should throw an error if first name is blank' do
      # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      @user = User.create(
        first_name: nil,
        last_name: 'Rogers',
        email: 'bob@rogers.net',
        password: 'bobbeh',
        password_confirmation: 'bobbeh'
      )
      expect(@user.errors.full_messages).to include("First name can't be blank")
    end
    it 'it should throw an error if last name is blank' do
      # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
      @user = User.create(
        first_name: 'Bob',
        last_name: nil,
        email: 'bob@rogers.net',
        password: 'bobbeh',
        password_confirmation: 'bobbeh'
      )
      expect(@user.errors.full_messages).to include("Last name can't be blank")
    end
  end

  describe '.authenticate_with_credentials' do
    it 'should return a user instance if provided with the correct password and email' do
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Rogers',
        email: 'bob@rogers.com',
        password: 'bobbeh',
        password_confirmation: 'bobbeh'
      )
      @our_user = User.authenticate_with_credentials(@user.email, @user.password)
      expect(@our_user.id).to be_present
    end
    it 'should not return a user instance if provided with the correct password and email' do
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Rogers',
        email: 'bob@rogers.com',
        password: 'bobbeh',
        password_confirmation: 'bobbeh'
      )
      @our_user = User.authenticate_with_credentials(@user.email, 'bobby')
      expect(@our_user).to be_nil
    end
    it 'should still validate a user if they have leading and trailing spaces with their email' do
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Rogers',
        email: 'bob@rogers.com',
        password: 'bobbeh',
        password_confirmation: 'bobbeh'
      )
      @our_user = User.authenticate_with_credentials('  bob@rogers.com ', @user.password)
      expect(@our_user.id).to be_present
    end
    it 'should ignore case when accepting the email' do
      @user = User.create(
        first_name: 'Bob',
        last_name: 'Rogers',
        email: 'bob@rogers.com',
        password: 'bobbeh',
        password_confirmation: 'bobbeh'
      )
      @our_user = User.authenticate_with_credentials('BOB@roGErs.com', @user.password)
    end
  end
end

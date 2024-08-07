class User < ApplicationRecord
  has_secure_password

  def self.find_record(params)
    user = find_by(params)
    if user
      puts "User db record found"
      return user
    else
      puts "User db record not found"
      return nil
    end
  end

  def self.authenticate_password(user, password)
    if user.authenticate(password)
      puts "User pw correct"
      return true
    else
      puts "User pw incorrect"
      return false
    end
  end

  def self.find_all_names_same_phone(phone_number)
    where(phone_number: phone_number).select(:id, :full_name)
  end
end
class User < ApplicationRecord
  has_secure_password

  def self.find_record(display_name)
    user = find_by(display_name: display_name)
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
end

# def self.authenticate(display_name, password, phone_number)
#   user = find_by(full_name: full_name, phone_number: phone_number)
#   if user && user.authenticate(password)
#     puts "User db record found"
#     return user
#   else
#     puts "User db record not found"
#     return nil
#   end
# end
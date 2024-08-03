class User < ApplicationRecord
  has_secure_password

def self.authenticate(full_name, phone_number, password)
    user = find_by(full_name: full_name, phone_number: phone_number)
    if user && user.authenticate(password)
      puts "Pw correct"
      return user
    else
      puts "pw incorrect"
      return nil
    end
  end
end

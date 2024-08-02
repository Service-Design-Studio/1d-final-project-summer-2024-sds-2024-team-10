class User < ApplicationRecord
  has_secure_password

  def self.authenticate(full_name, phone_number, password)
    user = find_by(full_name: full_name, phone_number: phone_number)
    user && user.authenticate(password) ? user : nil
  end
end

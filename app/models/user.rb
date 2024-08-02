class User < ApplicationRecord
  has_secure_password

  def self.authenticate(name, phone_number, password)
    user = find_by(full_name: name, phone_number: phone_number)
    user && user.authenticate(password) ? user : nil
  end
end

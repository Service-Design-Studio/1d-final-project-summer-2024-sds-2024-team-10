class UserUpdaterService
  def self.update_user(id, updates_hash)
    user = User.find(id)
    user.update(updates_hash)
  end
end

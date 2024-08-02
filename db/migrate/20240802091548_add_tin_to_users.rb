class AddTinToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :tin, :string
  end
end

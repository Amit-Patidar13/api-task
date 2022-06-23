class AddDetailsToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :contact, :integer
    add_column :users, :age, :integer
    add_column :users, :city, :string
  end
end

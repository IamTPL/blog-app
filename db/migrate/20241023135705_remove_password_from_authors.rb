class RemovePasswordFromAuthors < ActiveRecord::Migration[6.1]
  def change
    remove_column :authors, :password, :string
  end
end

class AddDefaultToRoleInUsers < ActiveRecord::Migration[8.0]
  def change
    change_column_default :users, :role, "無料会員"
  end
end

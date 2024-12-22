class FixDefaultToRoleInUsers < ActiveRecord::Migration[8.0]
  def up
    change_column_default :users, :role, from: nil, to: "free"
  end

  def down
    change_column_default :users, :role, from: "free", to: nil
  end
end

class CreateColumPermisionLevel < ActiveRecord::Migration[5.0]
  def change
    add_column :users,:permission_level, :integer, default: 1
  end
end

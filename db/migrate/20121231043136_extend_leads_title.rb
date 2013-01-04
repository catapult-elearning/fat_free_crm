class ExtendLeadsTitle < ActiveRecord::Migration
  def up
    change_column(:leads, :title, :string, :limit => 100, :null => false, :default => "")
  end

  def down
    change_column(:leads, :title, :string, :limit => 64, :null => false, :default => "")
  end
end

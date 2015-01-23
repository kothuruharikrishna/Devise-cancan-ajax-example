class ChangeNumericFieldInCommentsTable < ActiveRecord::Migration
  def change
  	change_column :comments, :rating, :decimal, :precision => 10, :scale => 2
  end
end

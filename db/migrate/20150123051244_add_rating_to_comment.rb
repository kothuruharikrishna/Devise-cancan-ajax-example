class AddRatingToComment < ActiveRecord::Migration
  def change
  	add_column :comments,:rating,:decimal
  end
end

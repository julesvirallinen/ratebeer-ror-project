class AddStyleRefToBeer < ActiveRecord::Migration
  def change
    add_reference :beers, :style, index: true, foreign_key: true
    remove_column :styles, :beer_id, :integer

  end
end

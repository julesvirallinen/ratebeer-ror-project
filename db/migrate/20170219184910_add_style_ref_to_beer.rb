class AddStyleRefToBeer < ActiveRecord::Migration
  def change
    create_table :styles do |t|
      t.string :name
      t.text :description

      t.timestamps null: false
    end

    add_reference :beers, :style, index: true, foreign_key: true
    remove_column :styles, :beer_id, :integer

  end
end

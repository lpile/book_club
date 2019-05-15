class CreateReviews < ActiveRecord::Migration[5.1]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :user
      t.integer :rating
      t.text :comment
      
      t.timestamps
    end
  end
end

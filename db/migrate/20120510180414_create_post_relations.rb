class CreatePostRelations < ActiveRecord::Migration
  def change
    create_table :post_relations do |t|
      t.integer :post_id
      t.integer :linked_post_id

      t.timestamps
    end
  end
end

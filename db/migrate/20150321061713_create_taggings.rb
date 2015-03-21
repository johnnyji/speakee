class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.references :hashtag, index: true
      t.references :confession, index: true

      t.timestamps null: false
    end
    add_foreign_key :taggings, :hashtags
    add_foreign_key :taggings, :confessions
  end
end

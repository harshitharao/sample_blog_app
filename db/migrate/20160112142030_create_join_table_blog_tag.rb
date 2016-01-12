class CreateJoinTableBlogTag < ActiveRecord::Migration
  def self.up
    create_table :blogs_tags, :id => false do |t|
      t.integer :blog_id
      t.integer :tag_id
    end

    add_index :blogs_tags, [:blog_id, :tag_id]
  end

  def self.down
    drop_table :blogs_tags
  end
end

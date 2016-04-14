class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.references :user, index: true, foreign_key: true
      t.string :title
      t.text :body

      t.timestamps null: false
    end
  end
end

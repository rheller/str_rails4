class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|

      t.string :title
      t.text :part1
      t.text :part2
      t.text :embedded
      t.text :links
      t.text :extra
      t.integer :next_page
      t.integer :prev_page 
      t.string :slug
      t.string :next_slug
      t.string :prev_slug
      t.timestamps
    end
    add_index :pages, :slug, unique: true
  end
end


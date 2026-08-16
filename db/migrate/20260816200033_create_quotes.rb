class CreateQuotes < ActiveRecord::Migration[8.1]
  def change
    create_table :quotes do |t|
      t.text :text
      t.string :author
      t.string :category

      t.timestamps
    end
  end
end

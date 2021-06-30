class CreateTodos < ActiveRecord::Migration[6.1]
  def change
    create_table :todos do |t|
      t.string :title
      t.string :url
      t.boolean :completed, default: false
      t.integer :order

      t.timestamps
    end
  end
end

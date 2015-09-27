class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text
      t.references :ticket, index: true, foreign_key: true
      t.references :author

      t.timestamps null: false
    end

    add_foreign_key :comments, :users, column: :author_id
  end
end

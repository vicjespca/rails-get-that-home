class CreateUsersProps < ActiveRecord::Migration[7.0]
  def change
    create_table :users_props do |t|
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true
      t.boolean :favorite
      t.boolean :contacted

      t.timestamps
    end
  end
end

class CreateProperties < ActiveRecord::Migration[7.0]
  def change
    create_table :properties do |t|
      t.string :address
      t.integer :type_operation
      t.integer :monthly_rent
      t.integer :maintanance
      t.integer :price
      t.integer :type_property
      t.integer :bedrooms
      t.integer :bathrooms
      t.integer :area
      t.boolean :pets_allowed
      t.string :description

      t.timestamps
    end
  end
end

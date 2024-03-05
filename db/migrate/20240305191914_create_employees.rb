class CreateEmployees < ActiveRecord::Migration[7.0]
  def change
    create_table :employees do |t|
      t.string :external_id
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :date_of_birth
      t.text :address
      t.string :country
      t.text :bio
      t.float :rating

      t.timestamps
    end
  end
end

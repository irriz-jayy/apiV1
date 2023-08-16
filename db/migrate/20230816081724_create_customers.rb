class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :surname
      t.string :email
      t.string :phone_number
      t.string :password_digest

      t.timestamps
    end
  end
end

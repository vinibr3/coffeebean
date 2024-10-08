class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name, default: '', null: false
      t.string :email, default: '', null: false
      t.text :password_digest

      t.timestamps
    end
  end
end

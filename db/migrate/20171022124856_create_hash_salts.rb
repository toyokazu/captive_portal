class CreateHashSalts < ActiveRecord::Migration[5.1]
  def change
    create_table :hash_salts do |t|
      t.string :salt
      t.timestamp :created_at
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end

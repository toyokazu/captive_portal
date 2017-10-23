class CreateIdentities < ActiveRecord::Migration[5.1]
  def change
    create_table :identities do |t|
      t.string :email
      t.string :name
      t.string :password_digest

      t.timestamps
    end
  end
end

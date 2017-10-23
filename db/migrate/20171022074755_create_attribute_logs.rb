class CreateAttributeLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :attribute_logs do |t|
      t.string :amac
      t.string :portal_locale
      t.string :locale
      t.string :location
      t.string :gender
      t.string :age_range
      t.string :timezone
      t.timestamp :created_at
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end

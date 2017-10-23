class CreateAccessLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :access_logs do |t|
      t.string :ap_type
      t.string :ap_mac
      t.string :essid
      t.string :mac
      t.string :ip
      t.string :uid
      t.string :provider
      t.boolean :agreement
      t.timestamp :created_at
      t.timestamp :deleted_at

      t.timestamps
    end
  end
end

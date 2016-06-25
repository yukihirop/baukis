class CreateStaffEvents < ActiveRecord::Migration
  def change
    create_table :staff_events do |t|
      #t.integer :staff_member, null: false　でもいい
      t.references :staff_member, null: false #職員レコードへの外部キ
      t.string :type, null: false #イベントタイプ
      t.datetime :created_at, null: false #発生時刻
    end

    add_index :staff_events, :created_at
    add_index :staff_events, [:staff_member_id, :created_at]
    # add_foreign_keyメソッドはgemパッケージforeignerによって提供される
    add_foreign_key :staff_events, :staff_members
  end
end

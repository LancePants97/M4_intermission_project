class CreateSubscriptions < ActiveRecord::Migration[7.1]
  def change
    create_table :subscriptions do |t|
      t.integer :tier
      t.float :price
      t.integer :status
      t.integer :frequency

      t.timestamps
    end
  end
end

class CreateFibonaccis < ActiveRecord::Migration[6.0]
  def change
    create_table :fibonaccis do |t|
      t.integer :input
      t.string :list

      t.timestamps
    end
  end
end

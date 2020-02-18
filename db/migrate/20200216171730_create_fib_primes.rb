class CreateFibPrimes < ActiveRecord::Migration[6.0]
  def change
    create_table :fib_primes do |t|
      t.text :list, array: true, default: []

      t.timestamps
    end
  end
end

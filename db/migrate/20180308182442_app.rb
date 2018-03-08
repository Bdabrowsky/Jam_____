class App < ActiveRecord::Migration[5.1]
  def change
  	create_table :users do |t|
      t.string :name
      t.digest :password
  end
end

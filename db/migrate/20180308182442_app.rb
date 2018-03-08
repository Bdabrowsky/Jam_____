class App < ActiveRecord::Migration[5.1]
  def change
  	create_table "users", force: :cascade do |t|
      t.string "name"
      t.string "password_digest"
  end
end

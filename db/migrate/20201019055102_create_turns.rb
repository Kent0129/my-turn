class CreateTurns < ActiveRecord::Migration[6.0]
  def change
    create_table :turns do |t|
      t.string :name,     null: false
      t.integer :number,  null: false
      t.integer :status,  null: false,  default: 0
      t.timestamps
    end
  end
end

class AddUserIdToTurns < ActiveRecord::Migration[6.0]
  def change
    add_reference :turns, :user, null: false, foreign_key: true
  end
end

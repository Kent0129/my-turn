class AddUserIdToTurns < ActiveRecord::Migration[6.0]
  def change
    add_reference :turns, :user, foreign_key: true
  end
end

class ChangeTypeStringToIntTurns < ActiveRecord::Migration[6.0]
  def change
    change_column :turns, :status, :string
    change_column_default :turns, :status, from: 0 , to: "待ち"
  end
end

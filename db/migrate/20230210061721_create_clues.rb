class CreateClues < ActiveRecord::Migration[7.0]
  def change
    create_table :clues do |t|
      t.json :file_content

      t.timestamps
    end
  end
end

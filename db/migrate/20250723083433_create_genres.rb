class CreateGenres < ActiveRecord::Migration[6.1]
  def change
    create_table :genres do |t|
      t.string :prefecture

      t.timestamps
    end
  end
end

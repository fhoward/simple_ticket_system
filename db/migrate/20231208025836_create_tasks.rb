class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.text :value
      t.text :message

      t.timestamps
    end
  end
end

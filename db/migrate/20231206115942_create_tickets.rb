class CreateTickets < ActiveRecord::Migration[7.0]
  def change
    create_table :tickets do |t|
      t.integer :requester_id
      t.string :status
      t.text :subject
      t.text :content

      t.timestamps
    end
  end
end

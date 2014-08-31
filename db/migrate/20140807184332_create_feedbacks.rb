class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.belongs_to :user

      t.string :title
      t.text :details
      t.string :status, null: false, default: "new"
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :detailed_location
      t.datetime :last_acted_at
      t.integer :reported_by

      t.timestamps
    end
  end
end

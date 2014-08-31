class AddImagedataToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :image1, :bytea
  	add_column :feedbacks, :image2, :bytea
  	add_column :feedbacks, :image3, :bytea
  	add_column :feedbacks, :image4, :bytea
  	add_column :feedbacks, :image5, :bytea
  end
end

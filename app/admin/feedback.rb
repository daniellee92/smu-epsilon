ActiveAdmin.register Feedback do


  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # permit_params :list, :of, :attributes, :on, :model
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  index do
    column :id
    column :title
    column :details
    column :status
    column :address
    column :detailed_location
    column :last_acted_at

    # For checking
    column :longitude
    column :latitude

    actions
  end

  filter :title
  filter :details
  filter :status, as: :select
  filter :address
  filter :detailed_location
  filter :last_acted_at

end

ActiveAdmin.register User do


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
    column :email
    column :nickname
    column :phone_number

    # For checking
    column :authentication_token
    column :verification_code
    column :created_at
    column :verified_at

    actions
  end

  filter :email
  filter :nickname
  filter :phone_number

end

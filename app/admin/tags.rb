ActiveAdmin.register Tag do
  menu label: 'Tags',
       parent: 'Device Manager'
  permit_params :user_id, :active, :uid, :device_position

  filter :user
  filter :uid
  filter :active

  index do
    selectable_column
    column :id
    column :uid
    column :active
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      input :uid
      input :active
      input :user
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :uid
      row :user
      row :active
      row :created_at
      row :updated_at
    end
  end

  searchable_select_options(
    scope: Tag.active,
    text_attribute: :id
  )
end

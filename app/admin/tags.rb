ActiveAdmin.register Tag do
  permit_params :user_id, :active, :tag_uid, :device_position

  filter :user
  filter :tag_uid
  filter :active

  index do
    selectable_column
    column :id
    column :tag_uid
    column :active
    column :device_position
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      input :tag_uid
      input :device_position
      input :active
      input :user
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :tag_uid
      row :user
      row :device_position
      row :active
      row :created_at
      row :updated_at
    end
  end
end

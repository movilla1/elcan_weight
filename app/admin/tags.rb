ActiveAdmin.register Tag do
  menu label: 'Tags',
       parent: 'Device Manager'
  permit_params :user_id, :active, :tag_uid, :device_position

  searchable_select_options(
    scope: Tag.active,
    text_attribute: :id
  )

  filter :user
  filter :tag_uid
  filter :active

  index do
    selectable_column
    column :id
    column :tag_uid
    column :active
    actions
  end

  form do |f|
    f.semantic_errors
    f.inputs do
      input :tag_uid
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
      row :active
      row :created_at
      row :updated_at
    end
  end
end

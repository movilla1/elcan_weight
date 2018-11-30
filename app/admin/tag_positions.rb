# frozen_string_literal: true

ActiveAdmin.register TagPosition do
  menu parent: "Device Manager"
  permit_params :tag_id, :device_id, :position

  filter :tag, as: :searchable_select, ajax: { resource: Tag }
  filter :device
  filter :position
  filter :created_at

  form do |f|
    f.semantic_errors
    f.inputs do
      f.input :tag
      f.input :device
      f.input :position
    end
    f.actions
  end
end

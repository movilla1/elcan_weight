# frozen_string_literal: true

ActiveAdmin.register Weight do
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :truck_id, :weight, :axis, :complete, :device_id, :user_id

  filter :truck, as: :searchable_select, ajax: true
  filter :user, as: :searchable_select, ajax: true
  filter :device
  filter :complete

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do # builds an input field for every attribute
      f.input :truck, as: :searchable_select, ajax: true
      f.input :axis
      f.input :device,
              as: :searchable_select,
              collection: Device.all.map { |x| [x.name, x.id] }
      f.input :user, as: :searchable_select, ajax: true
      f.input :complete, as: :select
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :truck
    column :weight
    column :user
    column :device
    column :created_at
    actions
  end
end

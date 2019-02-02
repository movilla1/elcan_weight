# frozen_string_literal: true

ActiveAdmin.register Weight do
  menu priority: 3
  # permit_params :list, :of, :attributes, :on, :model
  permit_params :truck_id, :weight, :device_id, :user_id, :second_weight

  filter :truck, as: :searchable_select, ajax: true
  filter :user, as: :searchable_select, ajax: true
  filter :device
  filter :complete

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do # builds an input field for every attribute
      f.input :truck, as: :searchable_select, ajax: true
      f.input :device,
              as: :searchable_select,
              collection: Device.all.map { |x| [x.name, x.id] }
      f.input :weight
      f.input :second_weight
      f.input :user, as: :searchable_select, ajax: true
    end
    f.actions
  end

  index do
    selectable_column
    column :id
    column :truck
    column I18n.t("net_weight") do |wr|
      wr.weight.to_f + wr.second_weight.to_f - wr.truck.empty_weight.to_f
    end
    column :user
    column :device
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :id
      row :truck
      row :user
      row :weight
      row :second_weight
      row I18n.t("net_weight") do |weight_row|
        subtotal = weight_row.weight.to_f + weight_row.second_weight.to_f 
        subtotal - weight_row.try(:truck).try(:empty_weight).try(:to_f)
      end
      row :device
      row :created_at
      row :updated_at
    end
  end
end

# frozen_string_literal: true

ActiveAdmin.register Truck do
  menu priority: 3, label: proc { I18n.t('trucks') }

  permit_params :license, :purchased, :capacity, :active

  searchable_select_options(
    scope: Truck.all,
    text_attribute: :license
  )
  filter :license
  filter :purchased
  filter :capacity
  filter :active
  
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do # builds an input field for every attribute
      f.input :license
      f.input :purchased, as: :datepicker, autocomplete: false
      f.input :capacity
      f.input :active
    end
    f.actions # adds the 'Submit' and 'Cancel' buttons
  end

  show do |truck_row|
    attributes_table do
      row :active
      row :license
      row :purchased
      row :capacity
      row :created_at
      row :updated_at
    end
    panel I18n.t('users_by_time') do
      columns do
        truck_row.users.each do |usr|
          column do
            span t('driver')
            span ':'
            span link_to usr.username, admin_user_path(usr)
          end
          column do
            span t('last_driven')
            span ':'
            max_weight_date = truck_row.weights.where(user_id: usr.id).maximum('weights.created_at')
            span max_weight_date
          end
        end
      end
    end
  end
end

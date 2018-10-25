# frozen_string_literal: true

ActiveAdmin.register Truck do
  menu priority: 3, label: proc { I18n.t('trucks') }

  permit_params :license, :purchased, :capacity, :active

  searchable_select_options(scope: Truck.all,
    text_attribute: :license)

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
end

# frozen_string_literal: true

ActiveAdmin.register TrucksUser do
  permit_params :user_id, :truck_id

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do # builds an input field for every attribute
      f.input :user, as: :searchable_select, ajax: true
      f.input :truck, as: :searchable_select, ajax: true
      f.input :created_at
    end
    f.actions # adds the 'Submit' and 'Cancel' buttons
  end
end

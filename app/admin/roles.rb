# frozen_string_literal: true

ActiveAdmin.register Role do
  menu parent: 'User Manager'
  # permit_params :list, :of, :attributes, :on, :model

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
end

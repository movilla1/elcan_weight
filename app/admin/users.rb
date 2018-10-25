# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 4, label: proc { I18n.t('users') }
  permit_params :name, :lastname

  searchable_select_options(scope: User.all,
    text_attribute: :email)
end

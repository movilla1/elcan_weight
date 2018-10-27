# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 4, label: proc { I18n.t('users') }
  permit_params :nombre, :apellido, :legajo, :username, :email

  searchable_select_options(
    scope: User.all,
    text_attribute: :email
  )

  filter :username
  filter :email
  filter :legajo
  filter :apellido
  filter :nombre

  index do
    selectable_column
    column :id
    column :email
    column :username
    column :nombre
    column :apellido
    column :legajo
    actions
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs do # builds an input field for every attribute
      f.input :username
      f.input :email
      f.input :nombre
      f.input :apellido
      f.input :legajo
      f.input :slug
    end
    f.actions # adds the 'Submit' and 'Cancel' buttons
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  show do
    attributes_table do
      row :username
      row :email
      row :nombre
      row :apellido
      row :legajo
      row :slug
      row :last_sign_in_ip
      row :last_sign_in_at
      row :reset_password_sent_at
      row :sign_in_count
    end
  end

  action_item :see_trucks, only: :show do
    link_to t('see_trucks_used'), trucks_driven_admin_user_path
  end

  member_action :trucks_driven, title: I18n.t('trucks_driven') do
    user = User.find(params[:id])
    render 'admin/user/trucks_driven', locals: {
      trucks: user.trucks,
      user: user
    }
  end
end

# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 4, label: proc { I18n.t('users') }
  permit_params %i[
    nombre
    apellido
    legajo
    username
    email
    slug
    password
    password_confirmation
  ]

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
      f.input :password, as: :password
      f.input :password_confirmation, as: :password
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

  action_item :assign_truck, only: :show do
    link_to t('assign_truck'), assign_truck_admin_user_path
  end

  member_action :trucks_driven, title: I18n.t('trucks_driven') do
    user = User.find(params[:id])
    render 'admin/user/trucks_driven', locals: {
      trucks: user.trucks,
      user: user
    }
  end

  member_action :assign_truck, title: I18n.t('assign_truck') do
    user = User.find(params[:id])
    render 'admin/user/assign_truck', locals: { user: user }
  end

  member_action :perform_assignment, method: :post do
    user = User.find(params[:id])
    if user.blank?
      flash[:error] = t('user_not_existent')
      redirect_to admin_users_path and return
    end
    truck_id = params["user"]["truck"]
    ut = TrucksUser.create!(user_id: user.id, truck_id: truck_id)
    if ut.present?
      redirect_to(
        admin_user_path(user),
        notice: t('truck_assigned_ok')
      ) and return
    else
      flash[:warning] = t('failed_truck_assignment')
      redirect_to admin_user_path(user) and return
    end
  end
end

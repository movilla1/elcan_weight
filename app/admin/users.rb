# frozen_string_literal: true

ActiveAdmin.register User do
  menu priority: 4,
       id: "User",
       label: proc { I18n.t("users") },
       parent: "User Manager"
  includes :roles
  permit_params [
    :nombre,
    :apellido,
    :legajo,
    :username,
    :email,
    :slug,
    :password,
    :password_confirmation,
    roles_attributes: %i[id role]
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
    column :role do |row|
      row.roles.each do |rol|
        div class: "role-display" do
          rol.role.humanize
        end
      end
    end
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
      has_many :roles do |nf|
        nf.input :role, as: :select
      end
    end
    f.actions # adds the 'Submit' and 'Cancel' buttons
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end
  end

  show do |user_row|
    div class: "col-md-5" do
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
    div class: "col-md-5" do
      div class: "row" do
        div class: "col-md-8" do
          panel I18n.t("roles") do
            user_row.roles.each do |role_row|
              div class: "role-display" do
                role_row.role.humanize
              end
            end
          end
        end
      end
      div class: "row" do
        div class: "col-md-8" do
          panel I18n.t("trucks") do
            user_row.trucks.each do |truck_row|
              div class: "role-display" do
                truck_row.display_string
              end
            end
          end
        end
      end
    end
  end

  action_item :see_trucks, only: :show do
    link_to t("see_trucks_used"), trucks_driven_admin_user_path
  end

  action_item :assign_truck, only: :show do
    link_to t("assign_truck"), assign_truck_admin_user_path
  end

  member_action :trucks_driven, title: I18n.t("trucks_driven") do
    user = User.find(params[:id])
    render "admin/user/trucks_driven", locals: {
      trucks: user.trucks,
      user: user
    }
  end

  member_action :assign_truck, title: I18n.t("assign_truck") do
    user = User.find(params[:id])
    render "admin/user/assign_truck", locals: { user: user }
  end

  member_action :perform_assignment, method: :post do
    user = User.find(params[:id])
    if user.blank?
      flash[:error] = t("user_not_existent")
      redirect_to(admin_users_path) && return
    end
    truck_id = params["user"]["truck"]
    ut = TrucksUser.create!(user_id: user.id, truck_id: truck_id)
    if ut.present?
      redirect_to(
        admin_user_path(user),
        notice: t("truck_assigned_ok")
      ) && return
    else
      flash[:warning] = t("failed_truck_assignment")
      redirect_to(admin_user_path(user)) && return
    end
  end
end

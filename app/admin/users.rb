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
    :role_ids
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
    column :user_roles do |row|
      row.roles.each do |rol|
        next if rol.blank?
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
        nf.input :role, as: :searchable_select, collection: Role.roles
      end
    end
    f.actions # adds the 'Submit' and 'Cancel' buttons
  end

  controller do
    def find_resource
      scoped_collection.friendly.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      roles = params[:user].delete(:role_ids)
      if permitted_params[:user][:password].blank?
        _pwd = permitted_params[:user].delete(:password)
        _pwd_c = permitted_params[:user].delete(:password_confirmation)
        @user.update_without_password(permitted_params[:user])
      else
        @user.update_attributes(permitted_params[:user])
      end
      if @user.errors.blank?
        update_roles(roles)
        redirect_to admin_users_path, notice: t("user_update_success")
      else
        render :edit
      end
    end

    def update_roles(roles)
      return if @user.blank?
      @user.roles.destroy_all
      clean_roles = roles.reject &:empty?
      clean_roles.each do |s_role|
        @user.roles.create!(role: s_role.to_i) if s_role.present?
      end
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

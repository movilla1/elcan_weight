# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    panel I18n.t('system_for') do
      div class: 'blank_slate_container' do
        img src: '/images/logo-big.jpg', height: '300px'
      end
      div class: 'blank_slate_container', id: 'dashboard_default_message' do
        span class: 'blank_slate' do
          span I18n.t('admin_welcome_message')
        end
      end
    end
    columns do
      column do
        panel I18n.t("online_users") do
          ul do
            User.all.each do |user|
              li link_to user.email, admin_user_path(user)
            end
          end
          div class: "pull-right"
            strong I18n.t("total") + ": #{User.all.count}"
        end
      end
      column do
        panel I18n.t("active_trucks") do
          ul do
            Truck.active.each do |truck|
              li link_to truck.license, admin_truck_path(truck)
            end
          end
        end
      end
    end
    # Here is an example of a simple dashboard with columns and panels.
    #
    # columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end

    #   column do
    #     panel "Info" do
    #       para "Welcome to ActiveAdmin."
    #     end
    #   end
    # end
  end # content
end

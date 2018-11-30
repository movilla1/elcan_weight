# frozen_string_literal: true

ActiveAdmin.register Intrussion do
  menu parent: "Device Manager"
  actions :all, except: %i[new update edit create]
  # permit_params :list, :of, :attributes, :on, :model

  index do
    selectable_column
    column :attemp_date
    column :tag
    column :device do |row|
      link_to row.device, admin_device_path(row.device)
    end
    column :created_at
    actions defaults: false do |row|
      dropdown_menu t("actions") do
        item t("add_to_device"),
             add_to_device_admin_intrussion_path(id: row.id),
             method: :patch
        item t("view"), admin_intrussion_path(row)
        item t("delete"),
             admin_intrussion_path(row),
             method: :delete,
             confirm: t("are_you_sure")
      end
    end
  end

  member_action :add_to_device, method: :patch do
    i_record = Intrussion.find(params[:id])
    device = Device.find(i_record.device)
    tag_uid = i_record.tag
    tag_position = TagPosition.new(device_id: device.id, tag_id: tag_id, position: nil)
    redirect_to new_admin_tag_position_path(tag_position)
  end
end

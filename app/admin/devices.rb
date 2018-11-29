# frozen_string_literal: true

ActiveAdmin.register Device do
  menu parent: "Device Manager"
  permit_params [
    :uid,
    :name,
    :username,
    :pass,
    :net_addr,
    tag_positions_attributes: %i[id tag_id position _destroy]
  ]

  filter :uid
  filter :tags
  filter :created_at
  filter :updated_at

  index do
    selectable_column
    column :id
    column :name
    column :uid
    column :net_addr
    column :created_at
    actions
  end

  show do
    attributes_table do
      row :uid
      row :name
      row :net_addr
      row :username
      row :pass do |dev|
        dev.pass.chars.map { |_x| "*" }.join + "*" * rand(5)
      end
      row :created_at
      row :updated_at
    end
  end

  sidebar I18n.t("tags_on_device"), only: %i[show edit] do
    table_for device.tag_positions do
      column :tag do |tagpos|
        link_to tagpos.tag.uid, admin_tag_path(tagpos.tag), target: "_blank"
      end
      column :position
      column :destroy do |tagpos|
        link_to "X", admin_tag_position_path(tagpos), method: :delete, confirm: I18n.t("are_you_sure")
      end
    end
  end

  form do |f|
    f.semantic_errors
    f.inputs heading: I18n.t("device") do
      f.input :uid
      f.input :name
      f.input :net_addr
      f.input :username
      f.input :pass, as: :password
    end
    f.inputs do
      f.has_many :tag_positions,
                 heading: I18n.t("tags_on_device"),
                 new_record: true,
                 allow_destroy: true do |nf|
        nf.input :tag_id, as: :searchable_select, ajax: { resource: Tag }
        nf.input :position
      end
    end
    f.actions
  end
end

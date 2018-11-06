# frozen_string_literal: true

ActiveAdmin.register Intrussion do
  actions :all, except: %i[new update edit create]
  # permit_params :list, :of, :attributes, :on, :model

  index do
    selectable_column
    column :attemp_date
    column :tag do |row|
      row.tag.each_byte do |c|
        format('%02X', c)
      end
    end
    column :device do |row|
      row.device.each_byte do |c|
        format('%02X', c)
      end
    end
    column :created_at
    actions
  end
end

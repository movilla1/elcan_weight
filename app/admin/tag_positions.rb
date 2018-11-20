ActiveAdmin.register TagPosition do
 permit_params :tag_id, :device_id, :position

 filter :tag, as: :searchable_select, ajax: { resource: Tag }
 filter :device
 filter :position
 filter :created_at

end

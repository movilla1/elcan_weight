class ChangeTagsTagUidToUid < ActiveRecord::Migration
  def change
    rename_column :tags, :tag_uid, :uid
  end
end

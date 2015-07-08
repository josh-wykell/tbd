class MakeCommentsPolymorphic < ActiveRecord::Migration
  def change
    rename_column :comments, :link_id, :commentable_id
    change_column :comments, :commentable_id, :integer, :index => true, :foreign_key => false
    add_column :comments, :commentable_type, :string
  end
end

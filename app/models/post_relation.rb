class PostRelation < ActiveRecord::Base
  attr_accessible :linked_post_id, :post_id

  belongs_to :post

  belongs_to :linked_post, :class_name => 'Post'
end

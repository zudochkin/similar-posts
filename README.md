# Simple example of self referencial model
We have two models: **Post**(`name, text`) and **PostRelation**(`post_id, linked_post_id`)

##### PostRelation model

  class PostRelation < ActiveRecord::Base
    attr_accessible :linked_post_id, :post_id

    belongs_to :post

    belongs_to :linked_post, :class_name => 'Post'
  end

##### Post model

  class Post < ActiveRecord::Base
    attr_accessible :name, :text

    attr_accessible :linked
    attr_reader :linked

    has_many :post_relations

    has_many :linked_posts, :through => :post_relations

    def linked=(ids)
      self.linked_post_ids = ids.split(",")
      PostRelation.where(['post_id in (?)', self.linked_post_ids])
        .where(['linked_post_id = ?', self.id])
        .map(&:destroy)
      self.linked_post_ids.each{ |i| PostRelation.create(:post_id => i, :linked_post_id => self.id) }
    end

    def self.search q
      Post.where(Post.arel_table[:name].matches("%#{ q }%"))
    end
  end

Is't ugly attempt to realize self referencial relation?

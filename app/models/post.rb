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

class FavoriteBlockSerializer < ApplicationSerializer
  attributes :id, :text, :category_id, :title, :owing_user
  belongs_to :profile_block
  lazy_has_many :favorite_block_likes
  lazy_has_many :users, through: :favorite_block_likes

  def title
    object.category.name
  end
end

class Post < ApplicationRecord
  belongs_to :user
  has_many :likes, as: :likeable

  before_create :initialize_likes_count

  private

  def initialize_likes_count
    self.likes_count = 0
  end
end
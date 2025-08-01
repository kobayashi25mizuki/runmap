class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  belongs_to :genre
  has_many :post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true
  validates :address, presence: true
  validates :genre_id, presence: true

  geocoded_by :address
  after_validation :geocode

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def self.search_for(content, field = :title)
    case field
    when :genre
      joins(:genre).where('genres.prefecture LIKE ?', "%#{content}%")
    else
      where('title LIKE ?', "%#{content}%")
    end
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end

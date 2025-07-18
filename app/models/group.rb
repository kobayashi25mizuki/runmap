class Group < ApplicationRecord

  has_one_attached :image
  belongs_to :owner, class_name: 'User'
  has_many :group_users, dependent: :destroy
  has_many :users, through: :group_users

  validates :name, presence: true
  validates :introduction, presence: true

  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end

  def is_owned_by?(user)
    owner.id == user.id
  end
  
  def approved_users
    group_users.approved.includes(:user).map(&:user)
  end

  def self.search_for(content, method)
    if method == 'perfect'
      Group.where(name: content)
    elsif method == 'forward'
      Group.where('name LIKE ?', content + '%')
    elsif method == 'backward'
      Group.where('name LIKE ?', '%' + content)
    else
      Group.where('name LIKE ?', '%' + content + '%')
    end
  end
  
end

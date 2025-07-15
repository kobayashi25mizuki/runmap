class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  # 状態を管理するenum
  enum status: { pending: 'pending', approved: 'approved', rejected: 'rejected' }

  # 状態別の絞り込みに使えるスコープ
  scope :pending, -> { where(status: 'pending') }
  scope :approved, -> { where(status: 'approved') }
end

class Entry < ApplicationRecord
  default_scope { order(created_at: :desc) }
  validates :location, :note, :user_id, presence: true

  has_one_attached :photo

  belongs_to :user
end

class Entry < ApplicationRecord
  default_scope { order(created_at: :desc) }
  validates :location, :note, :user_id, presence: true

  belongs_to :user

end
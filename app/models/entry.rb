class Entry < ApplicationRecord
  default_scope { order(created_at: :desc) }
  validates :city, :note, :temperature, :user_id, presence: true

  belongs_to :user

end
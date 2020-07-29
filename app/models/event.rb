class Event < ApplicationRecord
  belongs_to :creator, class_name: User.name, foreign_key: 'user_id'
  has_many :event_users
  has_many :attendees, :through => :event_users, :source => :attendee
  has_many :invite_users
  has_many :invited_users, :through => :invite_users, :source => :invited_user

  scope :past, -> { where("date < ?", Time.now) }
  scope :upcoming, -> { where("date > ?", Time.now) }


  validates :name, presence: true, length: { minimum: 3, maximum: 255 }
  validates :location, presence: true, length: { minimum: 3, maximum: 255 }
  validates :description, presence: true, length: { minimum: 3 }
  validates :date, presence: true
  validate :date_is_in_future

  def date_is_in_future
    if date && date < Time.now
      errors.add(:date, "cannot be in the past.")
    end
  end
end

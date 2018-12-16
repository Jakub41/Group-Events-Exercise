# == Schema Information
#
# Table name: group_events
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :text
#  start_date  :date
#  end_date    :date
#  duration    :integer
#  status      :integer          default("draft")
#  latitude    :decimal(10, 6)
#  longitude   :decimal(10, 6)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class GroupEvent < ApplicationRecord
  enum status: [:draft, :published]

  validates :name,        presence: true
  validates :status,      presence: true
  validates :description, presence: true, if: :published?
  validates :latitude,    presence: true, if: :published?
  validates :longitude,   presence: true, if: :published?
  validates :start_date,  presence: true, if: -> { published? && (!end_date? || !duration?) }
  validates :end_date,    presence: true, if: -> { published? && (!start_date? || !duration?)}
  validates :duration,    presence: true, if: -> { published? && (!start_date? || !end_date?)}

  validate :end_after_start,  if: -> { start_date? && end_date? }
  validate :correct_duration, if: -> { start_date? && end_date? && duration? }

  before_save :calculate_duration,   if: -> { start_date? && end_date? && !duration? }
  before_save :calculate_end_date,   if: -> { start_date? && !end_date? && duration? }
  before_save :calculate_start_date, if: -> { !start_date? && end_date? && duration? }

  acts_as_paranoid

  private

  def end_after_start
    errors.add(:end_date, 'must be after the start date') if end_date < start_date
  end

  def correct_duration
    errors.add(:duration, 'is not correct') if end_date - start_date != duration
  end

  def calculate_duration
    self.duration = end_date - start_date
  end

  def calculate_end_date
    self.end_date = start_date + duration
  end

  def calculate_start_date
    self.start_date = end_date - duration
  end
end

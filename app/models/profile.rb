# == Schema Information
#
# Table name: profiles
#
#  id                 :bigint           not null, primary key
#  user_id            :bigint           not null, foreign_key
#  height             :integer          not null
#  gender             :integer          not null
#  birthday           :datetime         not null
#  day_of_joinning    :datetime         not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)

# app/models/profile.rb
class Profile < ApplicationRecord
  # association =============
  belongs_to :user

  # enum =============
  enum gender: { male: 0, female: 1 }
  enum blood_type: { A: 0, B: 1, AB: 2, O: 3 }

  # validation =============
  validates :height, presence: true, numericality: true
  validates :gender, presence: true
  validates :prefecture_id, presence: true
  validates :blood_type, presence: true
  validates :birthday, presence: true
  validate  :birthday_cannot_be_in_the_future
  validates :day_of_joinning, presence: true

  # scope ==========
  scope :by_team, ->(user) { includes(user: :team).where(teams: { workspace_id: User.find(user.id).team.workspace_id }) }
  scope :recently_joined, -> { order(day_of_joinning: :desc).limit(3) }
  scope :filter_by_birth_month, -> (month) { where('extract(month from birthday) = ?', month).order("extract(day from birthday) ASC") }

  # custom validation =============
  def birthday_cannot_be_in_the_future
    errors.add(:birthday, 'に未来の日付は使えません') if birthday.present? && birthday > Time.zone.today
  end

  # active hash =============
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  # generate_public_uid ==========
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(10)

  def to_param
    public_uid
  end
end

# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  name               :string(255)      default(""), not null
#  email              :string(255)      not null, unique: true
#  provider           :string(255)      default(""), not null
#  uid                :string(255)      not null, unique: true
#  image              :string(255)
#  team_id            :string(255)      not null
#  encrypted_password :string(255)      not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  reset_password_token    :string(255)
#  reset_password_sent_at  :string(255)
#  remember_created_at     :string(255)
#
# Indexes
#
#  index_users_on_email                    (email)
#  index_users_on_reset_password_token     (reset_password_token)

# app/models/user.rb
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, :omniauthable

  mount_uploader :image, ImageUploader


  # association
  has_one :profile,       dependent: :destroy
  has_one :profile_block, dependent: :destroy
  belongs_to :team

  has_many :text_block_likes, dependent: :destroy
  has_many :text_blocks, through: :text_block_likes
  has_many :question_block_likes, dependent: :destroy
  has_many :question_blocks, through: :question_block_likes
  has_many :ranking_block_likes, dependent: :destroy
  has_many :ranking_blocks, through: :ranking_block_likes
  has_many :yes_or_no_block_likes, dependent: :destroy
  has_many :yes_or_no_blocks, through: :yes_or_no_block_likes

  # validation
  validates :name,                      presence: true
  validates :email,                     presence: true, uniqueness: { case_sensitive: true }
  validates :encrypted_password,        presence: true

  # after_create Seedを入れるときコメントアウト
  after_create :create_profile_block

  def self.from_omniauth(auth, user_info)
    user = find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを作成
    user.name = user_info.dig('user', 'name')
    user.email = user_info.dig('user', 'email')
    user.image = user_info.dig('user', 'image_192')
    user.check_team_existence(user_info.dig('team'))
    user.tokens = auth.info.authed_user.access_token
    user.save!
    user
  end

  # ユーザーが所属するチームがTeamテーブルにあるかどうかを確認
  def check_team_existence(team_info)
    workspace_id = team_info.dig('id')
    name = team_info.dig('name')
    image = team_info.dig('image_230')

    self.team = if Team.exists?(workspace_id: workspace_id)
                  Team.find_by(workspace_id: workspace_id)
                else
                  # 無い場合は新規チームを作成し、ユーザーをそこに所属させる
                  Team.create!(name: name, workspace_id: workspace_id, image: image)
                end
  end
end

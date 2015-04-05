# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime
#  updated_at             :datetime
#  username               :string
#  admin                  :boolean
#  biography              :text
#  avatar                 :string
#  provider               :string
#  uid                    :string
#  steam_id               :string
#  email_approval         :boolean
#  email_reports          :boolean
#  email_comments         :boolean
#  email_news             :boolean
#

class User < ActiveRecord::Base
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:steam]

  has_many :submissions, :inverse_of => :creator, :dependent => :destroy, :foreign_key => 'creator_id'
  has_many :comments, :dependent => :destroy
  has_one :api_key, :dependent => :destroy

  has_many :liked_submissions, :as => :likable, :dependent => :destroy, :inverse_of => :user
  has_many :disliked_submissions, :as => :dislikable, :dependent => :destroy, class_name: 'Dislike'
  has_many :liked_comments, :as => :likable, :dependent => :destroy, :inverse_of => :user
  
  
  has_many :blog_posts, :inverse_of => :author, :dependent => :destroy

  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }
  validates_format_of :username, :with => /\A[A-Za-z0-9_-]+\Z/

  mount_uploader :avatar, AvatarUploader

  attr_accessor :login

  def to_s
    username
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

  def self.from_steam(auth)
    new_user = where(provider: auth.provider, uid: auth.uid).first_or_initialize do |user|
      user.email = "#{auth.uid}@steam-provider.com"
      temp = auth['info']['nickname']
      if User.where(username: temp)
        user.username = temp + Devise.friendly_token[1, 3]
      else
        user.username = auth['info']['nickname']
      end
      user.password = Devise.friendly_token[0, 20]
    end
    new_user.save(:validate => false)
    return new_user
  end
end

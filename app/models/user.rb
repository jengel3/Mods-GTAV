class User
  include Mongoid::Document
  include Mongoid::Timestamps::Created
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, :omniauth_providers => [:steam]

  validates :username, presence: true, uniqueness: true, length: { maximum: 16 }
  validates_format_of :username, :with => /\A[A-Za-z0-9_-]+\Z/

  attr_accessor :login

  ## Database authenticatable
  field :email,              type: String, default: ""
  field :encrypted_password, type: String, default: ""

  ## Recoverable
  field :reset_password_token,   type: String
  field :reset_password_sent_at, type: Time

  ## Rememberable
  field :remember_created_at, type: Time

  ## Trackable
  field :sign_in_count,      type: Integer, default: 0
  field :current_sign_in_at, type: Time
  field :last_sign_in_at,    type: Time
  field :current_sign_in_ip, type: String
  field :last_sign_in_ip,    type: String

  field :biography, type: String, default: ""

  field :username, type: String
  field :admin, type: Boolean, default: false

  field :provider, type: String
  field :uid, type: String

  has_many :submissions, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_one :api_key, :dependent => :destroy

  # likes
  has_many :liked_submissions, :as => :likable, :dependent => :destroy, class_name: 'Like'
  has_many :disliked_submissions, :as => :dislikable, :dependent => :destroy, class_name: 'Dislike'
  has_many :liked_comments, :as => :likable, :dependent => :destroy, class_name: 'Like'
  has_many :blog_posts, :inverse_of => :author, :dependent => :destroy

  ## Confirmable
  # field :confirmation_token,   type: String
  # field :confirmed_at,         type: Time
  # field :confirmation_sent_at, type: Time
  # field :unconfirmed_email,    type: String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, type: Integer, default: 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    type: String # Only if unlock strategy is :email or :both
  # field :locked_at,       type: Time

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      self.any_of({ :username =>  /^#{Regexp.escape(login)}$/i }, { :email =>  /^#{Regexp.escape(login)}$/i }).first
    else
      super
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

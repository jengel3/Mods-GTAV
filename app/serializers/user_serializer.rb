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
#  username               :string
#  admin                  :boolean
#  biography              :text
#  avatar                 :string
#  provider               :string
#  uid                    :string
#  steam_id               :string
#  email_approval         :boolean          default(TRUE)
#  email_reports          :boolean          default(TRUE)
#  email_comments         :boolean          default(TRUE)
#  email_news             :boolean          default(TRUE)
#

class UserSerializer < ActiveModel::Serializer
  attributes :username
end

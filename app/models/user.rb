class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :password, presence: true, format: { with: /\A(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}+\z/ }
  validates :nickname, presence: true
  validates :last_name, presence: true, format: { with: /\A[\p{Han}\p{Hiragana}\p{Katakana}]+\z/ }
  validates :first_name, presence: true, format: { with: /\A[\p{Han}\p{Hiragana}\p{Katakana}]+\z/ }
  validates :last_name_kana, presence: true, format: { with: /\A[\p{Katakana}ー]+\z/ }
  validates :first_name_kana, presence: true, format: { with: /\A[\p{Katakana}ー]+\z/ }
  validates :birthday, presence: true

  has_many :items
  has_many :orders
end

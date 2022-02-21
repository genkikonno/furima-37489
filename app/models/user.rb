class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence:true
  VALID_NAME_REGEX = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/
  validates :first_name,:last_name, presence:true, format: {with: VALID_NAME_REGEX, message: "漢字、ひらがな、全角カタカナでご入力下さい。"}
  VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/
  validates :first_name_kana,:last_name_kana, presence:true, format: {with: VALID_NAME_KANA_REGEX, message:"全角カタカナでご入力下さい。"}
  validates :birth_date, presence:true
end

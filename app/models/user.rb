class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence:true
  
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i.freeze
  validates :password, format: {with: VALID_PASSWORD_REGEX, message: 'には英字と数字の両方を含めて設定してください', allow_blank: true}

  VALID_NAME_REGEX = /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/.freeze
  validates :first_name,:last_name, 
    presence:true, 
    format: {with: VALID_NAME_REGEX, message: "には漢字、ひらがな、全角カタカナでご入力下さい", allow_blank: true}
  
    VALID_NAME_KANA_REGEX = /\A[ァ-ヶー－]+\z/.freeze
  validates :first_name_kana,:last_name_kana,
    presence:true, 
    format: {with: VALID_NAME_KANA_REGEX, message:"には全角カタカナでご入力下さい", allow_blank: true}

  validates :birth_date, presence:true
end

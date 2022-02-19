# テーブル設計

## usersテーブル
| Column             | Type   | Options                   |
| ------------------ | ------ | ------------------------- |
| nickname           | string | null: false               |
| email              | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| name               | string | null: false               |
| name-kana          | string | null: false               |
| birth-date         | date   | null: false               |

### Association
-has_many :items
-has_many :purchases

## itemsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| name               | string     | null: false                    |
| explanation        | text       | null: false                    |
| category           | string     | null: false                    |
| condition          | string     | null: false                    |
| delivery-charge    | integer    | null: false                    |
| delivery-date      | date       | null: false                    |
| price              | integer    | null: false                    |
| user               | references | null: false, foreign_key: true |

### Association
-has_one :purchases
-belongs_to :users

## purchase-listsテーブル
| Column             | Type       | Options                        |
| ------------------ | ---------- | ------------------------------ |
| user               | references | null: false, foreign_key: true |
| item               | references | null: false, foreign_key: true |
| cord-number        | string     | null: false                    |
| expiration-date    | date       | null: false                    |
| security-code      | string     | null: false                    |
| post-code          | string     | null: false                    |
| prefectures        | string     | null: false                    |
| city               | string     | null: false                    |
| address            | string     | null: false                    |
| building-name      | string     |                                |
| phone-number       | string     | null: false                    |

### Association
-belongs_to :users
-belongs_to :items



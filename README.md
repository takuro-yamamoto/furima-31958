# テーブル設計

## users テーブル

| Column     | Type    | Options     |
| ---------- | ------- | ----------- |
| email      | string  | null: false |
| password   | string  | null: false |
| nickname   | string  | null: false |
| name_full  | string  | null: false |
| name_kana  | string  | null: false |
| birthday   | integer | null: false |

### Association

- has_many :items
- has_many :purchases

## items テーブル

| Column          | Type       | Options           | 
| --------------- | ---------- | ----------------- |
| name            | string     | null: false       |
| description     | text       | null: false       |
| category        | string     | null: false       |
| condition       | string     | null: false       |
| delivery_fee    | string     | null: false       |
| shipment_source | string     | null: false       |
| days_to_ship    | string     | null: false       |
| price           | integer    | null: false       |
| user            | references | foreign_key: true |

### Association

- belongs_to :user
- has_one :purchase

## purchases テーブル

| Column          | Type       | Options           |
| --------------- | ---------- | ----------------- |
| card_number     | integer    | null: false       |
| expiration_date | integer    | null: false       |
| security_code   | integer    | null: false       |
| postal_code     | string     | null: false       |
| prefectures     | string     | null: false       |
| municipality    | string     | null: false       |
| address         | string     | null: false       |
| building        | string     |                   |
| phone_number    | integer    | null: false       |
| user            | references | foreign_key: true |
| item            | references | foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item

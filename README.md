# テーブル設計

## users テーブル

| Column          | Type   | Options      |
| --------------- | ------ | -------------|
| nickname        | text   | null: false  |
| email           | string | null: false  |
| password        | string | null: false  |
| last_name       | text   | null: false  |
| first_name      | text   | null: false  |
| last_name_kana  | text   | null: false  |
| first_name_kana | text   | null: false  |
| birth_date      | integer| null: false  |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column                   | Type       | Options                        |
| ------------------------ | ---------- | ------------------------------ |
| item_name                | text       | null: false                    |
| item_info                | text       | null: false                    |
| item_category            | integer    | null: false                    |
| item_sales_status        | integer    | null: false                    |
| item_shipping_fee_status | integer    | null: false                    |
| item_prefecture          | integer    | null: false                    |
| item_scheduled_delivery  | integer    | null: false                    |
| item_price               | string     | null: false                    |
| user                     | references | null: false, foreign_key: true |

### Association

- has_one :order
- belongs_to :user


## orders テーブル

| Column   | Type       | Options                        |
| -------- | ---------- | ------------------------------ |
| user     | references | null: false, foreign_key: true |
| item     | references | null: false, foreign_key: true |

### Association

- belongs_to :user, :item
- has one :address

## addresses テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal_code  | string     | null: false                    |
| prefecture   | integer    | null: false                    |
| city         | string     | null: false                    |
| addresses    | string     | null: false                    |
| building     | string     | null: true                     |
| phone_number | string     | null: false                    |
| order        | references | null: false, foreign_key: true |

### Association

- belongs_to :order
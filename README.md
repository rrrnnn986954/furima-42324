# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## usersテーブル
| Column              | Type   | Options                   |
| ------------------- | ------ | ------------------------- |
| nickname            | string | null: false               |
| email               | string | null: false, unique: true |
| encrypted_password | string | null: false               |
| last_name          | string | null: false               |
| first_name         | string | null: false               |
| last_name_kana    | string | null: false               |
| first_name_kana   | string | null: false               |
| birthday            | date   | null: false               |

Association
has_many :items
has_many :purchases


## itemsテーブル
| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| name               | string     | null: false                     |
| email               | text       | null: false                     |
| category_id       | integer    | null: false                     |
| condition_id      | integer    | null: false                     |
| delivery_fee_id  | integer    | null: false                     |
| prefecture_id     | integer    | null: false                     |
| delivery_day_id | integer    | null: false                     |
| price              | integer    | null: false                     |
| user               | references | null: false, foreign_key: true |

Association
belongs_to :user
has_one :purchase


## purchasesテーブル
| Column | Type       | Options                         |
| ------ | ---------- | ------------------------------- |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |

Association
belongs_to :user
belongs_to :item
has_one :destination

## destinationsテーブル
| Column         | Type       | Options                         |
| -------------- | ---------- | ------------------------------- |
| postal_code   | string     | null: false                     |
| prefecture_id | integer    | null: false                     |
| city           | string     | null: false                     |
| address        | string     | null: false                     |
| building       | string     |                                 |
| phone_number  | string     | null: false                     |
| order          | references | null: false, foreign_key: true |

Association
belongs_to :purchase

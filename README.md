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
| encrypted\_password | string | null: false               |
| last\_name          | string | null: false               |
| first\_name         | string | null: false               |
| last\_name\_kana    | string | null: false               |
| first\_name\_kana   | string | null: false               |
| birthday            | date   | null: false               |

Association
has_many :items
has_many :orders
has_many :comments
has_many :favorites
has_many :reports
has_many :purchases
has_one :destination


## itemsテーブル
| Column             | Type       | Options                         |
| ------------------ | ---------- | ------------------------------- |
| name               | string     | null: false                     |
| text               | text       | null: false                     |
| category\_id       | integer    | null: false                     |
| condition\_id      | integer    | null: false                     |
| delivery\_fee\_id  | integer    | null: false                     |
| prefecture\_id     | integer    | null: false                     |
| delivery\_days\_id | integer    | null: false                     |
| price              | integer    | null: false                     |
| user               | references | null: false, foreign\_key: true |

Association
belongs_to :user
has_one :order

## purchasesテーブル
| Column | Type       | Options                         |
| ------ | ---------- | ------------------------------- |
| user   | references | null: false, foreign\_key: true |
| item   | references | null: false, foreign\_key: true |

Association
belongs_to :user
belongs_to :item
has_one :address

## destinationsテーブル
| Column         | Type       | Options                         |
| -------------- | ---------- | ------------------------------- |
| postal\_code   | string     | null: false                     |
| prefecture\_id | integer    | null: false                     |
| city           | string     | null: false                     |
| address        | string     | null: false                     |
| building       | string     |                                 |
| phone\_number  | string     | null: false                     |
| order          | references | null: false, foreign\_key: true |

Association
belongs_to :order

## commentsテーブル
| Column | Type       | Options                         |
| ------ | ---------- | ------------------------------- |
| comment   | text     | null: false                     |
| user   | references | null: false, foreign\_key: true |
| item   | references | null: false, foreign\_key: true |

Association
belongs_to :user
belongs_to :item


## favoritesテーブル
| Column | Type       | Options                         |
| ------ | ---------- | ------------------------------- |
| user   | references | null: false, foreign\_key: true |
| item   | references | null: false, foreign\_key: true |

Association
belongs_to :user
belongs_to :item


## reportsテーブル
| Column | Type       | Options                         |
| ------ | ---------- | ------------------------------- |
| user   | references | null: false, foreign\_key: true |
| item   | references | null: false, foreign\_key: true |

Association
belongs_to :user
belongs_to :item
# Boards Todo App

## 概要

課題毎にタスク管理をする TODO アプリ

## 主な機能

- ユーザー機能
  - ユーザーにはログイン・ログアウト状態がある
- ボード機能
  - ユーザーに紐づくボードを作成できる
  - ボードにはタイトル・概要がある
- タスク機能
  - ボードに紐づくタスクを作成できる
  - タスクにはタイトル・内容・期限がある
- コメント機能
  - タスクに紐づくコメントを作成できる
  - コメントには内容がある

## 技術スタック

### Backend

![Ruby on Rails](https://skillicons.dev/icons?i=rails)
![PostgreSQL](https://skillicons.dev/icons?i=postgresql)

- Ruby on Rails
- PostgreSQL

### Frontend

![HTML](https://skillicons.dev/icons?i=html)
![CSS](https://skillicons.dev/icons?i=css)
![JavaScript](https://skillicons.dev/icons?i=js)
![Tailwind CSS](https://skillicons.dev/icons?i=tailwind)

- HTML（HAML）
- CSS（Tailwind CSS）
- JavaScript

### Infrastructure

![AWS](https://skillicons.dev/icons?i=aws)
![Heroku](https://skillicons.dev/icons?i=heroku)

- AWS
- Heroku

## モデル

| モデル名 | 用途                               | リレーション                                                |
| -------- | ---------------------------------- | ----------------------------------------------------------- |
| User     | ログイン・ログアウト機能           | has_many :boards<br>has_many :tasks<br>has_many :comments   |
| Board    | ユーザーが作成するタスク管理ボード | belongs_to :user<br>has_many :tasks                         |
| Task     | ボードに紐づくタスク               | belongs_to :user<br>belongs_to :board<br>has_many :comments |
| Comment  | タスクに対するコメント             | belongs_to :user<br>belongs_to :task                        |

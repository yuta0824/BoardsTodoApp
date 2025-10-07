users_config = [
  { key: :yamada, name: '山田', email: ENV['SEED_YAMADA_EMAIL'], password: ENV['SEED_YAMADA_PASSWORD'], avatar: 'avatar_yamada.png' },
  { key: :tanaka, name: '田中', email: ENV['SEED_TANAKA_EMAIL'], password: ENV['SEED_TANAKA_PASSWORD'], avatar: 'avatar_tanaka.png' },
  { key: :yuta, name: 'Yuta', email: ENV['SEED_YUTA_EMAIL'], password: ENV['SEED_YUTA_PASSWORD'], avatar: 'avatar_yuta.png' }
]

boards_config = [
  {
    owner: :yamada,
    name: 'Sweet Delight',
    description: 'スイーツショップのWebサイト制作',
    tasks: [
      {
        owner: :yamada, name: 'ヘッダー', description: 'ヒーロー画像とヘッダーのコーディング', due_date: Date.today + 3, thumbnail: 'task1-1.jpg'
      },
      {
        owner: :tanaka, name: '当店について', description: '画像とテキストの2列デザイン', due_date: Date.today + 5, thumbnail: 'task1-2.jpg'
      },
      {
        owner: :yamada, name: '今月のケーキ', description: 'メニューセクションのコーディング', due_date: Date.today + 7, thumbnail: 'task1-3.jpg',
        comments: [
          { author: :tanaka, content: 'カルーセル案を追加しました。' },
          { author: :yuta, content: 'スマホでは 2 枚表示に切り替えたいです。' },
          { author: :yamada, content: '切り替え速度は 4 秒に設定しました。' },
          { author: :tanaka, content: 'ラベルの背景色をブランドカラーに合わせています。' }
        ]
      },
      {
        owner: :yuta, name: 'SHOP情報', description: '登録メールアドレス宛に最新情報を送るシステムの構築', due_date: Date.today + 10, thumbnail: 'task1-4.jpg'
      }
    ]
  },
  {
    owner: :tanaka,
    name: 'OHA',
    description: '目覚ましマッチングアプリのWebサイト制作',
    tasks: [
      {
        owner: :yamada, name: 'ヘッダー', description: 'ヒーロー画像とヘッダーのコーディング', due_date: Date.today + 3, thumbnail: 'task2-1.jpg'
      },
      {
        owner: :tanaka, name: 'NEWS', description: 'CMSと連携して実装', due_date: Date.today + 5, thumbnail: 'task2-2.jpg',
        comments: [
          { author: :yamada, content: 'WordPress 側の API キーを共有済みです。' },
        ]
      },
      {
        owner: :yamada, name: 'MOVIE', description: 'YouTubeの埋め込み', due_date: Date.today + 7, thumbnail: 'task2-3.jpg',
        comments: [
          { author: :yamada, content: 'サムネイルの比率調整を行いました。' },
        ]
      },
      {
        owner: :yuta, name: 'CONTACT', description: 'Super Form 9 で実装', due_date: Date.today + 10, thumbnail: 'task2-4.jpg',
        comments: [
          { author: :tanaka, content: '送信先メールアドレスは info@oha.jp です。' },
          { author: :yamada, content: 'バリデーションは英語表記も入れてください。' },
          { author: :yuta, content: '確認画面の文言を整えました。' },
          { author: :tanaka, content: 'プライバシーポリシーへのリンクを追加しています。' }
        ]
      }
    ]
  },
  {
    owner: :yuta,
    name: '尾道レトロキャンペーン',
    description: 'Instagram投稿キャンペーンのWebサイト制作',
    tasks: [
      {
        owner: :yamada, name: 'ヘッダー', description: 'ヒーロー画像とヘッダーのコーディング', due_date: Date.today + 3, thumbnail: 'task3-1.jpg'
      },
      {
        owner: :tanaka, name: 'About', description: 'Aboutセクションの実装', due_date: Date.today + 5, thumbnail: 'task3-2.jpg',
        comments: [
          { author: :yamada, content: '文章は最終稿をアップしました。' },
          { author: :tanaka, content: '写真のクレジット表記を入れてあります。' },
          { author: :yuta, content: 'SP 時の上下余白を調整しました。' }
        ]
      },
      {
        owner: :yamada, name: '流れ続ける画像', description: 'Swiper.js でスライダーの実装', due_date: Date.today + 7, thumbnail: 'task3-3.jpg'
      },
      {
        owner: :yuta, name: 'よくある質問', description: '開閉式のQAを実装', due_date: Date.today + 10, thumbnail: 'task3-4.jpg',
        comments: [
          { author: :tanaka, content: 'QA は全部で 6 件になる予定です。' },
        ]
      }
    ]
  }
]

users = {}

users_config.each do |config|
  user = User.create!(name: config[:name], email: config[:email], password: config[:password])
  File.open(Rails.root.join("app/assets/images/dummy/#{config[:avatar]}")) do |file|
    user.avatar.attach(io: file, filename: config[:avatar])
  end
  users[config[:key]] = user
end

boards_config.each do |config|
  owner = users.fetch(config[:owner])
  board = owner.boards.create!(name: config[:name], description: config[:description])

  config[:tasks].each do |task_config|
    owner = users.fetch(task_config[:owner])
    task = board.tasks.create!(
      name: task_config[:name],
      description: task_config[:description],
      due_date: task_config[:due_date],
      user: owner
    )
    File.open(Rails.root.join("app/assets/images/dummy/#{task_config[:thumbnail]}")) do |file|
      task.thumbnail.attach(io: file, filename: task_config[:thumbnail])
    end

    (task_config[:comments] || []).each do |comment_config|
      author = users.fetch(comment_config[:author])
      task.comments.create!(
        user: author,
        content: comment_config[:content]
      )
    end
  end
end

User.create!(
  [
    {
      user_name:  "管理者",
      email: "admin@example.jp",
      password:  "11111111",
      password_confirmation: "11111111",
      admin: true
    },
    {
      user_name:  "番号発券",
      email: "issue@example.jp",
      password:  "11111111",
      password_confirmation: "11111111",
      admin: false
    }
  ]
)
        
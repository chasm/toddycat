TIME_TO_EXPIRE = 1.day

Registrant.destroy_all
User.destroy_all

Registrant.create([
  { email: "bob@munat.com" },
  { email: "bill@munat.com" },
  { email: "biff@munat.com" }
])

User.create([
  {
    id: SecureRandom.urlsafe_base64,
    name: "Chaz",
    email: "chas@munat.com",
    password: "123",
    password_confirmation: "123"
  },
  {
    id: SecureRandom.urlsafe_base64,
    name: "Chad",
    email: "chad@munat.com",
    password: "123",
    password_confirmation: "123"
  },
  {
    id: SecureRandom.urlsafe_base64,
    name: "Cad",
    email: "cad@munat.com",
    password: "123",
    password_confirmation: "123"
  }
])
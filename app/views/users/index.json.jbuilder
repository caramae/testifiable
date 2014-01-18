json.array!(@users) do |user|
  json.extract! user, :name, :email, :password, :is_admin
  json.url user_url(user, format: :json)
end
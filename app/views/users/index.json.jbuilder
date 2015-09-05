json.array!(@users) do |user|
  json.extract! user, :id, :name, :password_digest, :cluster_id
  json.url user_url(user, format: :json)
end

json.array!(@clusters) do |cluster|
  json.extract! cluster, :id, :name, :type_id, :team_id, :lease
  json.url cluster_url(cluster, format: :json)
end

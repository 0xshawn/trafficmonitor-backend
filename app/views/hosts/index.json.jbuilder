json.array!(@hosts) do |host|
  json.extract! host, :id, :mac, :hostname, :ip
  json.url host_url(host, format: :json)
end

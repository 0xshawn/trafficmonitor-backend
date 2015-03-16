json.array!(@connections) do |connection|
  json.extract! connection, :id, :local_ip, :download_speed, :remote_ip, :upload_speed, :total_send_rate, :total_receive_rate
  json.url connection_url(connection, format: :json)
end

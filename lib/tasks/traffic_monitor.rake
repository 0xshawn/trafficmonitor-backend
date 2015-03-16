namespace :traffic_monitor do
  require 'trafficmonitor'
  desc "monitor network connections and generate data point"
  task generate_data: :environment do
    #logger           = Logger.new(STDOUT)
    #logger.level     = Logger::INFO
    #Rails.logger     = logger

    class Monitor
      include Trafficmonitor::Iftop
    end

    monitor = Monitor.new
    result = monitor.connections 'en0', 2

    result['connection'].each do |i|
      local_ip = i['local_ip']
      download_speed = i['download_speed']
      remote_ip = i['remote_ip']
      upload_speed = i['upload_speed']

      conn = Connection.create(local_ip: local_ip, download_speed: download_speed,
                         remote_ip: remote_ip, upload_speed: upload_speed,
                         total_send_rate: result['total_send_rate:'],
                         total_receive_rate: result['total_receive_rate'])
      conn.save

      puts conn
      puts '---------'
    end
  end
end

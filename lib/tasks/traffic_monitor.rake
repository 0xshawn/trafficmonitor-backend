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

    #items = {"total_send_rate" => result['connection'].first['total_send_rate'],
    #         "total_receive_rate" => result['connection'].first['total_receive_rate']}
    items = {}

    result['connection'].each do |i|
      puts i
      local_ip = i['local_ip']
      download_speed = i['download_speed']
      remote_ip = i['remote_ip']
      upload_speed = i['upload_speed']

      if items.has_key? local_ip
        items[local_ip]["download_speed"] += download_speed
        items[local_ip]["upload_speed"] += upload_speed
      else
        items[local_ip] = {'download_speed' => download_speed,
                             'remote_ip' => remote_ip,
                             'upload_speed' => upload_speed }
      end

    end
    puts items
    items.each do |i|
      conn = Connection.create( local_ip: i[0],
                                download_speed: i[1]['download_speed'],
                                remote_ip: i[1]['remote_ip'],
                                upload_speed: i[1]['upload_speed'],
                                total_send_rate: result['connection'].first['total_send_rate'],
                                total_receive_rate: result['connection'].first['total_receive_rate'])
      conn.save
    end
  end
end

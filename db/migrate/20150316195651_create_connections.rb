class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections do |t|
      t.string :local_ip
      t.string :download_speed
      t.string :remote_ip
      t.string :upload_speed
      t.string :total_send_rate
      t.string :total_receive_rate

      t.timestamps
    end
  end
end

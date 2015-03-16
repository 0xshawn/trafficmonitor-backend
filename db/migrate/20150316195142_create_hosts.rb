class CreateHosts < ActiveRecord::Migration
  def change
    create_table :hosts do |t|
      t.string :mac
      t.string :hostname
      t.string :ip

      t.timestamps
    end
  end
end

class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :time
      t.references :patient
      t.references :doctor
    end
  end
end

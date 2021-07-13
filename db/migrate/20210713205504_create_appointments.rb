class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :time
      t.integer :doctor_id
      t.integer :patient_id
    end
  end
end

puts "it worked!"

[Appointment, Doctor, Patient].each do |klass|
  klass.destroy_all
end

doctor_attributes = [
  {
    name: "Dr. Drew", specialization: "Addiction Medicine"
  },
  {
    name: "Dr. Fauci", specialization: "Infectious Diseases"
  }
]
doctors = doctor_attributes.map do |attributes|
  Doctor.create(attributes)
end

patient_attributes = [
  {name: "Dennis Rodman"},
  {name: "Tom Hanks"}
]

patients = patient_attributes.map do |attributes|
  Patient.create(attributes)
end

Appointment.create(
  patient: patients[0],
  doctor: doctors[0],
  time: "2:00 PM"
)

Appointment.create(
  patient: patients[1],
  doctor: doctors[1],
  time: "11:30 AM"
)
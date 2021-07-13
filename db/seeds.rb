# don't forget to delete everything in your database at the beginning of this file!

Pet.destroy_all
Doctor.destroy_all
Appointment.destroy_all
Patient.destroy_all

Pet.create(name: "Fido", age: "2 years", breed: "Husky")

Doctor.create(name: "Dr. Drew", specialization: "Addiction Medicine")
Doctor.create(name: "Dr. Fauci", specialization:"Infectious Diseases")

Patient.create(name: "Dennis Rodman")
Patient.create(name: "Tom Hanks")

Appointment.create(doctor_id: 1, patient_id: 1, time:"2:00 PM")
Appointment.create(doctor_id: 2, patient_id: 2, time:"11:30 AM")
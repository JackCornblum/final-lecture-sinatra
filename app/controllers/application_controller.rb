require './config/environment'

class ApplicationController < Sinatra::Base
  register Sinatra::CrossOrigin

  configure do
    enable :cross_origin
    set :allow_origin, "*" 
    set :allow_methods, [:get, :post, :patch, :delete, :options] # allows these HTTP verbs
    set :expose_headers, ['Content-Type']
  end

  options "*" do
    response.headers["Allow"] = "HEAD,GET,PUT,POST,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    200
  end

  get "/pets" do
    Pet.all.to_json
  end

  post "/pets" do
    # binding.pry
    pet_params = params.select{|k,v| ["name", "age", "breed"].include?(k)}
    @pet = Pet.create(pet_params)
    @pet.to_json
  end

  patch "/pets/:id" do
    pet = Pet.find(params[:id])
    pet_params = params.select{|k,v| ["name", "age", "breed"].include?(k)}
    pet.update(pet_params)
    pet.to_json
  end

  delete "/pets/:id" do
    pet = Pet.find(params[:id])
    pet.destroy
    pet.to_json
  end

  get "/doctors" do
    Doctor.all.to_json
  end

  post "/new_doctor" do
    doctor_params = params.select{|k,v| ["name", "specialization"].include?(k)}
    doctor = Doctor.create(doctor_params)
    doctor.to_json
    # binding.pry
  end

  patch "/doctors/:id" do
    doctor = Doctor.find(params[:id])
    doctor_params = params.select{|k,v| ["name", "specialization"].include?(k)}
    doctor.update(doctor_params)
    doctor.to_json
  end

  delete "/doctors/:id" do
    doctor = Doctor.find(params[:id])
    doctor.destroy
    doctor.to_json
  end

  get "/patients" do
    Patient.all.to_json
  end

  post "/new_patient" do
    patient_params = params.select{|k,v| ["name"].include?(k)}
    patient = Patient.create(patient_params)
    patient.to_json
    # binding.pry
  end

  patch "/patients/:id" do
    patient = Patient.find(params[:id])
    patient_params = params.select{|k,v| ["name"].include?(k)}
    patient.update(patient_params)
    patient.to_json
  end

  delete "/patients/:id" do
    patient = Patient.find(params[:id])
    patient.destroy
    patient.to_json
  end

  get "/appointments" do
    Appointment.all.to_json
  end

  post "/new_appointment" do

    appointment_params = params.select{|k,v| ["time", "doctor_id", "patient_id"].include?(k)}
    appointment = Appointment.create(appointment_params)
    appointment.to_json(include: [:doctor, :patient])
    # binding.pry
  end

  patch "/appointments/:id" do
    appointment = Appointment.find(params[:id])
    appointment_params = params.select{|k,v| ["time", "doctor_id", "patient_id"].include?(k)}
    appointment.update(appointment_params)
    appointment.to_json(include: [:doctor, :patient])
  end

  delete "/appointments/:id" do
    appointment = Appointment.find(params[:id])
    appointment.destroy
    appointment.to_json(include: [:doctor, :patient])
  end

  get "/doctors/:id/appointments" do
    doctor = Doctor.find(params[:id])
    doctor.appointments.to_json(include: [:patient, :appointment])
    # binding.pry
  end

  post "/doctors/:id/appointments" do
    # appointment_params = params.select{|k,v| ["time", "id", "patient_id"].include?(k)}
    appointment = Appointment.create(doctor_id: params[:id], patient_id: params[:patient_id], time:params[:time])
    appointment.to_json(include: [:doctor, :patient])
    # binding.pry
  end


end

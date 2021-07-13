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

  get "/" do
    {hello: "world"}.to_json
  end

  get "/doctors" do 
    Doctor.all.to_json
  end

  post "/new_doctor" do 
    doctor = Doctor.create(
      name: params[:name], specialization: params[:specialization]
    )
    
    doctor.to_json
  end

  patch "/doctors/:id" do 
    doctor = Doctor.find(params[:id])
    attrs_to_update = params.select{|k,v| ["name", "specialization"].include?(k)}
    doctor.update(attrs_to_update)
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
    patient = Patient.create(
      name: params[:name]
    )
    patient.to_json
  end

  patch "/patients/:id" do 
    patient = Patient.find(params[:id])
    attrs_to_update = params.select{|k,v| ["name"].include?(k)}
    patient.update(attrs_to_update)
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
    appointment = Appointment.create(
      time: params[:time],
      doctor_id: params[:doctor_id],
      patient_id: params[:patient_id]
    )
    appointment.to_json(include: [:patient, :doctor])
  end

  patch "/appointments/:id" do 
    appointment = Appointment.find(params[:id])
    attrs_to_update = params.select{|k,v| ["time", "patient_id", "doctor_id"].include?(k)}
    appointment.update(attrs_to_update)
    appointment.to_json(include: [:patient, :doctor])
  end

  delete "/appointments/:id" do 
    appointment = Appointment.find(params[:id])
    appointment.destroy
    appointment.to_json(include: [:patient, :doctor])
  end

end

require 'rake'
require 'sinatra/activerecord/rake'
require_relative "spec_helper"

RSpec.describe "Advanced Deliverables - API Endpointments", skip_db_cleaner: true do 
  before(:each) do 
    Rake::Task["db:seed"].invoke
  end

  describe "get '/doctors/:id/appointments'" do 
    it "returns an array of appointment objects belonging to the doctor (whose id appears in the URL parameter) as a JSON formatted string" do 
      drew = Doctor.find_by(name: "Dr. Drew", specialization: "Addiction Medicine")
      dennis = Patient.find_by(name: "Dennis Rodman")
      get "/doctors/#{drew.id}/appointments"
      appointments = drew.appointments
      parsed = JSON.parse(last_response.body)
      appointment_times = parsed.map{|apt_attributes| apt_attributes["time"]}
      patient_names = parsed.map{|apt_attributes| apt_attributes["patient"]["name"] }
      expect(appointment_times).to include("2:00 PM")
      expect(patient_names).to include("Dennis Rodman")
      expect(patient_names).not_to include("Tom Hanks") unless drew.appointments.pluck(:patient_id).include?(dennis.id)
    end
  end

  describe "post '/doctors/:id/appointments" do 
    it "creates a new appointment in the database belonging to the doctor (whose id appears in the URL parameter) and returns it as a JSON formatted string" do 
        doctor = Doctor.find_or_create_by(name: "Dr. Fauci", specialization: "Addiction Medicine")
        patient = Patient.find_or_create_by(name: "Judi Dench")
        post_body = {
          time: "12:00 PM",
          patient_id: patient.id
        }
        post "/doctors/#{doctor.id}/appointments", post_body, { 'Content_Type' => 'application/json' }
        response = last_response.body
        expect(response.class).to eq(String)
        parsed = JSON.parse(response)
        expect(parsed).to be_a(Hash)
        expect(parsed.keys).to include("id", "time", "doctor", "patient")
        expect(parsed["time"]).to eq("12:00 PM")
        expect(parsed["doctor"]["name"]).to eq("Dr. Fauci")
        expect(parsed["patient"]["name"]).to eq("Judi Dench")
        expect(parsed["id"]).not_to be_nil
      end
  end


end
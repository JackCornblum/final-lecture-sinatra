require 'rake'
require 'sinatra/activerecord/rake'
require_relative "spec_helper"

RSpec.describe "API Endpointments", skip_db_cleaner: true do 
  before(:each) do 
    Rake::Task["db:seed"].invoke
  end

  describe "Doctors" do 
    describe "get '/doctors'" do 
      it "returns an array of doctor object as a JSON formatted string" do 
        get "/doctors" 
        body = last_response.body
        expect(body.class).to eq(String)
        parsed = JSON.parse(body)
        expect(parsed.class).to eq(Array)
        expect(parsed.length).to be > 1
        names = parsed.map do |hash|
          hash["name"]
        end
        expect(names).to include("Dr. Drew", "Dr. Fauci")
      end
    end
    
    describe "post '/new_doctor'" do 
      it "creates a new doctor in the database and returns it as a JSON formatted string" do 
        post_body = {
          name: "Dr. Jocelyn Elders",
          specialization: "Pediatric Endocrinology"
        }
        post "/new_doctor", post_body, { 'Content_Type' => 'application/json' }
        response = last_response.body
        expect(response.class).to eq(String)
        parsed = JSON.parse(response)
        expect(parsed).to be_a(Hash)
        expect(parsed.keys).to include("id", "name", "specialization")
        expect(parsed["name"]).to eq("Dr. Jocelyn Elders")
        expect(parsed["specialization"]).to eq("Pediatric Endocrinology")
        expect(parsed["id"]).not_to be_nil
      end
    end

    describe "patch '/doctors/:id'" do 
      it "creates a new doctor in the database and returns it as a JSON formatted string" do 
        post_body = {
          name: "Surgeon General Jocelyn Elders"
        }
        doctor = Doctor.create(
          name: "Dr. Jocelyn Elders",
          specialization: "Pediatric Endocrinology"
        )
        patch "/doctors/#{doctor.id}", post_body, { 'Content_Type' => 'application/json' }
        response = last_response.body
        expect(response.class).to eq(String)
        parsed = JSON.parse(response)
        expect(parsed).to be_a(Hash)
        expect(parsed.keys).to include("id", "name", "specialization")
        expect(parsed["name"]).to eq("Surgeon General Jocelyn Elders")
        expect(parsed["specialization"]).to eq("Pediatric Endocrinology")
        expect(parsed["id"]).not_to be_nil
      end
    end

    describe "delete '/doctors/:id'" do 
      it "deletes the record with the given id from the database and returns the delted object as a JSON formatted string" do 
        last_doctor = Doctor.last
        last_id = last_doctor.id
        delete "/doctors/#{last_id}"
        response = last_response.body
        expect(response.class).to eq(String)
        parsed = JSON.parse(response)
        expect(parsed).to be_a(Hash)
        expect(parsed.keys).to include("id", "name", "specialization")
        expect(Doctor.find_by(id: last_id)).to be_nil
      end
    end
  end

  describe "Patients" do 
    describe "get '/patients'" do 
      it "returns an array of patient objects as a JSON formatted string" do 
        get "/patients" 
        body = last_response.body
        expect(body.class).to eq(String)
        parsed = JSON.parse(body)
        expect(parsed.class).to eq(Array)
        expect(parsed.length).to be > 1
        names = parsed.map do |hash|
          hash["name"]
        end
        expect(names).to include("Dennis Rodman", "Tom Hanks")
      end
    end

    describe "post '/new_patient'" do 
      it "creates a new patient in the database and returns it as a JSON formatted string" do 
        post_body = {
          name: "Helen Mirren"
        }
        post "/new_patient", post_body, { 'Content_Type' => 'application/json' }
        response = last_response.body
        expect(response.class).to eq(String)
        parsed = JSON.parse(response)
        expect(parsed).to be_a(Hash)
        expect(parsed.keys).to include("id", "name")
        expect(parsed["name"]).to eq("Helen Mirren")
        expect(parsed["id"]).not_to be_nil
      end
    end

    describe "patch '/patients/:id'" do 
      it "creates a new patient in the database and returns it as a JSON formatted string" do 
        post_body = {
          name: "Dame Judi Dench"
        }
        patient = Patient.create(
          name: "Judi Dench"
        )
        patch "/patients/#{patient.id}", post_body, { 'Content_Type' => 'application/json' }
        response = last_response.body
        expect(response.class).to eq(String)
        parsed = JSON.parse(response)
        expect(parsed).to be_a(Hash)
        expect(parsed.keys).to include("id", "name")
        expect(parsed["name"]).to eq("Dame Judi Dench")
        expect(parsed["id"]).not_to be_nil
      end
    end

    describe "delete '/patients/:id'" do 
      it "deletes the record with the given id from the database and returns the delted object as a JSON formatted string" do 
        last_patient = Patient.last
        last_id = last_patient.id
        delete "/patients/#{last_id}"
        response = last_response.body
        expect(response.class).to eq(String)
        parsed = JSON.parse(response)
        expect(parsed).to be_a(Hash)
        expect(parsed.keys).to include("id", "name")
        expect(Patient.find_by(id: last_id)).to be_nil
      end
    end
  end

  describe "Appointments" do 
    describe "get '/appointments'" do 
      it "returns an array of appointment objects as a JSON formatted string" do 
        get "/appointments" 
        body = last_response.body
        expect(body.class).to eq(String)
        parsed = JSON.parse(body)
        expect(parsed.class).to eq(Array)
        expect(parsed.length).to be > 1
        times = parsed.map do |hash|
          hash["time"]
        end
        expect(times).to include("2:00 PM", "11:30 AM")
      end
    end

    describe "post '/new_appointment'" do 
      it "creates a new appointment in the database and returns it as a JSON formatted string" do 
        doctor = Doctor.find_or_create_by(name: "Dr. Fauci", specialization: "Addiction Medicine")
        patient = Patient.find_or_create_by(name: "Judi Dench")
        post_body = {
          time: "12:00 PM",
          doctor_id: doctor.id,
          patient_id: patient.id
        }
        post "/new_appointment", post_body, { 'Content_Type' => 'application/json' }
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

    describe "patch '/appointments/:id'" do 
      it "creates a new appointment in the database and returns it as a JSON formatted string" do 
        post_body = {
          time: "1:00 PM"
        }
        doctor = Doctor.find_or_create_by(name: "Dr. Fauci", specialization: "Addiction Medicine")
        patient = Patient.find_or_create_by(name: "Judi Dench")
        appointment = Appointment.find_or_create_by(
          time: "12:00 PM",
          doctor_id: doctor.id,
          patient_id: patient.id
        )
        patch "/appointments/#{appointment.id}", post_body, { 'Content_Type' => 'application/json' }
        response = last_response.body
        expect(response.class).to eq(String)
        parsed = JSON.parse(response)
        expect(parsed.keys).to include("id", "time", "doctor", "patient")
        expect(parsed["time"]).to eq("1:00 PM")
        expect(parsed["doctor"]["name"]).to eq("Dr. Fauci")
        expect(parsed["patient"]["name"]).to eq("Judi Dench")
        expect(parsed["id"]).not_to be_nil
      end
    end

    describe "delete '/appointments/:id'" do 
      it "deletes the record with the given id from the database and returns the delted object as a JSON formatted string" do 
        last_appointment = Appointment.last
        last_id = last_appointment.id
        delete "/appointments/#{last_id}"
        response = last_response.body
        expect(response.class).to eq(String)
        parsed = JSON.parse(response)
        expect(parsed).to be_a(Hash)
        expect(parsed.keys).to include("id", "time", "doctor", "patient")
        expect(Appointment.find_by(id: last_id)).to be_nil
      end
    end
  end

end
require_relative "spec_helper"

RSpec.describe "Models & Migrations" do 
  describe "Doctor" do 
    it "exists" do 
      expect{Doctor}.not_to raise_error
    end

    it "inherits from ActiveRecord::Base" do 
      expect(Doctor.superclass).to eq(ActiveRecord::Base)
    end

    it "has column names" do 
      expect(Doctor.column_names).to include("id", "name", "specialization")
    end
  end

  describe "Patient" do 
    it "exists" do 
      expect{Patient}.not_to raise_error
    end

    it "inherits from ActiveRecord::Base" do 
      expect(Patient.superclass).to eq(ActiveRecord::Base)
    end

    it "has column names" do 
      expect(Patient.column_names).to include("id", "name")
    end
  end

  describe "Appointment" do 
    it "exists" do 
      expect{Appointment}.not_to raise_error
    end

    it "inherits from ActiveRecord::Base" do 
      expect(Appointment.superclass).to eq(ActiveRecord::Base)
    end

    it "has column names" do 
      expect(Appointment.column_names).to include("id", "time", "patient_id", "doctor_id")
    end
  end

  describe "Associations" do 
    describe "Appointment" do 
      it "belongs to a doctor" do 
        expect(Appointment.new).to respond_to(:doctor)
      end

      it "belongs to a patient" do 
        expect(Appointment.new).to respond_to(:patient)
      end
    end

    describe "Patient" do 
      it "has many appointments" do 
        expect(Patient.new).to respond_to(:appointments)
      end

      it "has many doctors, through appointments" do 
        expect(Patient.new).to respond_to(:doctors)
      end
    end

    describe "Doctor" do 
      it "has many appointments" do 
        expect(Doctor.new).to respond_to(:appointments)
      end

      it "has many patients, through appointments" do 
        expect(Doctor.new).to respond_to(:patients)
      end
    end
  end
end
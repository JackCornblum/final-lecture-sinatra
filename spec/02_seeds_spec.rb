require 'rake'
require 'sinatra/activerecord/rake'
require_relative "spec_helper"

RSpec.describe "db/seeds.rb", skip_db_cleaner: true do
  def drew
    Doctor.find_by(name: "Dr. Drew", specialization: "Addiction Medicine")
  end
  def fauci
    Doctor.find_by(name: "Dr. Fauci", specialization: "Infectious Diseases")
  end
  def dennis
    Patient.find_by(name: "Dennis Rodman")
  end
  def tom
    Patient.find_by(name: "Tom Hanks")
  end
  before(:each) do 
    Rake::Task["db:seed"].invoke
  end
  describe "for doctors" do 
    it "creates 2 doctors" do
      expect(drew).to be_a(Doctor)
      expect(fauci).to be_a(Doctor)
    end
  end

  describe "for patients" do 
    it "creates 2 patients" do 
      expect(dennis).to be_a(Patient)
      expect(tom).to be_a(Patient)
    end
  end

  describe "for appointments" do 
    it "creates 2 appointments" do 
      expect(Appointment.find_by(time: "2:00 PM", patient: dennis, doctor: drew)).to be_an(Appointment)
      expect(Appointment.find_by(time: "11:30 AM", patient: tom, doctor: fauci)).to be_an(Appointment)
    end
  end
end

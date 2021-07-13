# Sinatra API CRUD

In today's exercise, we'll be building out a doctor - patient - appointment domain. The first step will be to build out the models and migrations. Next, we'll create seed data so that our api will have some data to start out with

1. Models & migrations
2. Seed Data & Test Relationships in Console
3. Build out API endpoints to implement CRUD

### Resources:

- [Sinatra API CRUD Reference](https://hackmd.io/@dlm/sinatra-crud-cheatsheet)
- [Sinatra API Testing](https://hackmd.io/@dlm/testing-your-sinatra-api)
- [Sinatra Documentation](http://sinatrarb.com/intro.html)
- [ActiveRecord to_json docs](https://apidock.com/rails/ActiveRecord/Serialization/to_json)

## 1. Models & Migrations

There are 3 classes and tables you'll need to create:

- Doctor
  - name
  - specialization
- Patient
  - name
- Appointment
  - time (as a string)
  - doctor_id
  - patient_id

In the first part of the exercise, you'll also be putting together the relationships between your models.

## 2. Seed Data & Test Relationships in Console

For this portion, you'll want to create a seeds file that will start by destroying all existing data in the database. You can create additional records if you like, but at the minimum, your seeds file should create:

- 2 Doctors
  - 1 named "Dr. Drew" specializing in "Addiction Medicine"
  - 1 named "Dr. Fauci" specializing in "Infectious Diseases"
- 2 Patients
  - 1 named "Dennis Rodman"
  - 1 named "Tom Hanks"
- 2 appointments
  - 1 at "2:00 PM" for Dennis Rodman with Dr. Drew
  - 1 at "11:30 AM" for Tom Hanks with Dr. Fauci

Once you've built out the seeds, you can run them using `rake db:seed`. After that, you can run the `tux` command.

Once you're in the console, try out the associations.

```rb
Appointment.first.doctor
```

```rb
Appointment.last.patient
```

```rb
Doctor.first.appointments
```

```rb
Doctor.last.patients
```

```rb
Patient.first.appointments
```

```rb
Patient.last.doctors
```

## 3. Build out API endpoints to implement CRUD

You'll be implementing CRUD for all 3 models. For testing purposes, all routes must be defined within the `app/controllers/application_controller.rb` file. 

- `Doctor`
  - get '/doctors'
  - post '/new_doctor'
  - patch '/doctors/:id'
  - delete '/doctors/:id'
- `Patient`
  - get '/patients'
  - post '/new_patient'
  - patch '/patients/:id'
  - delete '/patients/:id'
- `Appointment`
  - get '/appointments'
  - post '/new_appointment'
  - patch '/appointments/:id'
  - delete '/appointments/:id'
  

## 4. Advanced Deliverables

- get '/doctors/:id/appointments'
- post '/doctors/:id/appointments'
- get '/patients/:id/appointments'
- post '/patients/:id/appointments'
- get '/doctors_by_specialization/:specialization'

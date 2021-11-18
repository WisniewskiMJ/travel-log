# TRAVEL LOG
Travel Log is personal travel diary. You can add place location and a note, and the app will add current date, your geographic coordinates and the temperature at that location.

Live version: [Travel Log](https://travellerdiary.herokuapp.com/)

### Features:
- setting up account with email autentication
- signing in with Google account
- adding place location and note
- showing geographical coordinates and temperature at the location
- editing location name and note
- deleting entry

### Technologies used:
* Ruby 3.0.2
* Rails 6.1.4
* Haml
* Bootstrap 5
* PostgreSQL
* RSpec
* StandardRB

### Integrations
* Gmail for Action Mailer
* Google Sign-In
* Geocoder with Nominatim API
* OpenWeatherMap API

### Setup

To run locally, you have to have Ruby in version 3.0.2 installed on your machine.
Next you have to execute 
```
.bin/setup
```
which will install bundler and create database. 
Then you have to run 
```
bundle exec rails server
```
and the app will be available at __localhost:3000__ in your browser.

### To do

* Add service for editing entries
* Add end to end tests
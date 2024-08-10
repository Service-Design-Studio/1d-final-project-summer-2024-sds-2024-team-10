# 1D Final Project - Summer 2024 (Team 10)

This repository contains the source code for our 1D Final Project for the Summer 2024 session, developed by Team 10 of the Service Design Studio. This application is designed to enhance the user experience for the DBS Deposit Account application process by allowing customers to resume their application progress, eliminating the need for manual data re-entry.

## Table of Contents
- [Ruby Version](#ruby-version)
- [System Dependencies](#system-dependencies)
- [Configuration](#configuration)
- [Database Initialization](#database-initialization)
- [How to Run the Test Suite](#how-to-run-the-test-suite)
- [MicroServices](#microservices)
- [Deployment Instructions](#deployment-instructions)
- [Design Workbook](#design-workbook)
- [Contributors](#contributors)

## Ruby Version
This project is built using Ruby `version 3.2.4`. Ensure that you have the correct version installed by running:
ruby -v

## System Dependencies

To run this application, you will need to have the following dependencies installed:

- Ruby on Rails `7.1.3`
- SQLite3 `1.4` for the development and test databases
- PostgreSQL for production
- Twilio-Ruby for sending OTPs
- Additional dependencies are listed in the Gemfile

## Configuration

To configure the application:

1. Clone the repository:
   git clone https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-10.git
   cd 1d-final-project-summer-2024-sds-2024-team-10

2. Install the required gems:
   bundle install

## Database Initialization

Run the following command to initialize the database and load the schema:

rails db:migrate

## How to Run the Test Suite

We use RSpec and Cucumber for testing. To run the test suite:

rspec
bundle exec cucumber

This will execute all unit tests, integration tests, and feature tests.

## MicroServices

- OCR Data Extraction Microservice using Gemini1.5
- OTP Authentication Microservice using Twilio
- Camera and Image Upload

## Deployment Instructions

The application is deployed on Google Cloud Platform. To deploy:

1. Ensure all dependencies are up to date.
2. Run the following command to deploy:
   gcloud builds submit
3. You can access the deployed application here: [Deployed Application](https://dbs5-tqs6erweea-as.a.run.app/).

## Design Workbook

For more details on the design, please refer to our [Design Workbook](https://docs.google.com/document/d/1NKNe5zba8b4IR6PJ0jwitwsROz2DFnMIl5cKZIuibT4/edit?usp=sharing).

## Contributors

- **Team 10** - Service Design Studio, Summer 2024
- Lam Yu En - 1007103 - samuellam123
- Ernest Tan Wei Yan - 1006883 - Qaisel
- Pare Moulik - 1007158 - moulikpare
- Pettugani Sahitya - 1007098 - SahityaPettugani
- Lee Wan Wei - 1007307 - wanweileee
- Ryan Goh Wen Long - 1006661 - ryangohwl

Special Thanks to our DBS mentors: Jarene and Jie Ling

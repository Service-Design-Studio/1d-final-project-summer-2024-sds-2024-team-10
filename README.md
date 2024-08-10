# 1D Final Project - Summer 2024 (Team 10)

This repository contains the source code for our 1D Final Project for the Summer 2024 session, developed by Team 10 of the Service Design Studio. This application is designed to enhance the user experience for the DBS Deposit Account application process by allowing customers to resume their application progress, eliminating the need for manual data re-entry.

## Table of Contents
- [Ruby Version](#ruby-version)
- [System Dependencies](#system-dependencies)
- [Configuration](#configuration)
- [Database Creation](#database-creation)
- [Database Initialization](#database-initialization)
- [How to Run the Test Suite](#how-to-run-the-test-suite)
- [Services](#services)
- [Deployment Instructions](#deployment-instructions)
- [Design Workbook](#design-workbook)
- [Deployed Application](#deployed-application)
- [Contributors](#contributors)

## Ruby Version
This project is built using Ruby `version X.X.X`. Ensure that you have the correct version installed by running:
```bash
ruby -v

## System Dependencies

To run this application, you will need to have the following dependencies installed:

- Ruby on Rails `X.X.X`
- PostgreSQL `X.X`
- Redis `X.X.X`
- Node.js `X.X.X` with npm `X.X.X`
- Yarn `X.X.X`

## Configuration

To configure the application:

1. Clone the repository:
   ```bash
   git clone https://github.com/Service-Design-Studio/1d-final-project-summer-2024-sds-2024-team-10.git
   cd 1d-final-project-summer-2024-sds-2024-team-10

2. Install the required gems:
   ```bash
   bundle install

3. Install JavaScript dependencies:
   ```bash
   yarn install

## Database Creation

To set up the database, run:

```bash
rails db:create

## Database Initialization

Run the following command to initialize the database and load the schema:

```bash
rails db:migrate

## How to Run the Test Suite

We use RSpec and Cucumber for testing. To run the test suite:

```bash
rspec
bundle exec cucumber

This will execute all unit tests, integration tests, and feature tests.

## Services

## Services

The application relies on the following services:

- **Redis**: For caching and job queuing.
- **Sidekiq**: To handle background jobs.

## Deployment Instructions

The application is deployed on Google Cloud Platform. To deploy:

1. Ensure all dependencies are up to date.
2. Run the following command to deploy:
   ```bash
   gcloud app deploy
3. The application is accessible at: Deployed Application.

## Design Workbook

For more details on the design, please refer to our [Design Workbook](https://docs.google.com/document/d/1NKNe5zba8b4IR6PJ0jwitwsROz2DFnMIl5cKZIuibT4/edit?usp=sharing).

## Deployed Application

You can access the deployed application here: [Deployed Application](https://dbs5-tqs6erweea-as.a.run.app/).

## Contributors

- **Team 10** - Service Design Studio, Summer 2024

# FullStack Mobile Fitness App - Gym Dashboard

Welcome to the Gym Dashboard, a FullStack Mobile Fitness App project! This repository contains everything you need to get started with our fitness application.

## Table of Contents

- [Introduction](#introduction)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The Gym Dashboard is a FullStack Mobile Fitness App designed to help you track your fitness journey effectively. It provides features such as workout planning, progress tracking, and much more.

## Prerequisites

Before you begin, ensure you have met the following requirements:

- [Node.js](https://nodejs.org/) installed on your system.
- [Yarn](https://classic.yarnpkg.com/en/docs/install/) installed on your system.

## Installation

1. Clone the repository to your local machine:

   ```shell
   git clone git@github.com:Tewodros01/FullStackFitnessApp.git
   cd FullStackFitnessApp
   ```

2. Install backend dependencies:

   ```shell
   cd backend
   yarn install
   ```

### Database Migration for Development Server

Before running the database migration, ensure that you have updated the "type" property in the backend `package.json` file. Modify or remove the line `"type": "module"` as needed. After completing the migration, remember to revert the change in the backend `package.json` file.

1. To run the database migration, use the following command:

   ```shell
   db-migrate up
   ```

2. To start the development server, run:

   ```shell
   yarn start
   ```

3. Install Gym-Dashboard dependencies:

   ```shell
   cd ../gym-dashboard
   yarn install
   ```

4. To start the Gym-Dashboard, run:

   ```shell
   yarn dev
   ```

## Usage

Once the server is running, open your web browser and navigate to [http://localhost:5173/](http://localhost:5173/) to access the Gym Dashboard. You can now use the Gym Dashboard to plan your workouts and track your fitness progress.

## Contributing

We welcome contributions from the community. If you'd like to contribute to this project, please follow our [Contribution Guidelines](CONTRIBUTING.md).

## License

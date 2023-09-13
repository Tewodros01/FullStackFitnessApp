# FullStack Mobile Fitness App

## Getting Started

Welcome to our FullStack Mobile Fitness App, the Gym Dashboard! This project serves as our final project, and we're excited to get you started.

### Prerequisites

Before you begin, make sure you have [Node.js](https://nodejs.org/) and [Yarn](https://classic.yarnpkg.com/en/docs/install/) installed on your system.

### Installation

1. Clone the repository to your local machine:
   git clone git@github.com:Tewodros01/FullStackFitnessApp.git
   cd FullStackFitnessApp

### Starting the Development Server

1. Install project dependencies using Yarn:
   cd backend
   yarn install

### Database Migration for Development Server

!!!!Before running the database migration, ensure that you have updated the "type" property in the backend `package.json` file. Modify or remove the line `"type": "module"` as needed. After completing the migration, remember to revert the change in the backend `package.json` file.

1. To run the database migration, use the following command:
   db-migrate up

2. To start the development server, run the following command:
   yarn start

Once the server is running,

### Starting the Gym-Dashboard

1. Install project dependencies using Yarn:
   cd gym-dashboard
   yarn install

2. To start the Gym-Dashboard, run the following command:
   yarn dev

open your web browser and navigate to [http://localhost:5173/](http://localhost:5173/) to access the Gym Dashboard.

You are now ready to explore and use the Gym Dashboard for your fitness journey. Enjoy!

## License

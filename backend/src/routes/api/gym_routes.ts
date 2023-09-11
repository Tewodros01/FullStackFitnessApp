import express from "express";
import GymController from "../../controllers/gym_controllers.js";

const gymRouter: express.Router = express();
gymRouter.post("/", GymController.createNewGym);

export default gymRouter;

import express from "express";
import GymController from "../../controllers/gym_controllers.js";

const gymRouter: express.Router = express();

gymRouter.post("/login", GymController.gymLogin);
gymRouter.get("/:gym_id", GymController.getGymUsers);
gymRouter.get("/", GymController.getAllGym);
gymRouter.post("/register", GymController.createNewGym);

export default gymRouter;

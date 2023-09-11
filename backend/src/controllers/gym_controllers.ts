import { Request, Response, NextFunction } from "express";
import { Gym, GymStore } from "../models/gym.js";

class GymController {
  static createNewGym = async (req: Request, res: Response): Promise<void> => {
    const gymStore: GymStore = new GymStore();
    const name = req.body.gym_name;
    if (!name) {
      res.status(400).json({ error: "Name is required for the gym." });
      return;
    }

    try {
      const gym = await gymStore.createGym(name);
      if (gym) {
        res.status(201).json(gym);
      } else {
        res.status(500).json({ error: "Failed to create the gym." });
      }
    } catch (error) {
      console.error("Error creating gym:", error);
      res.status(500).json({ error: "Internal Server Error" });
    }
  };
}

export default GymController;

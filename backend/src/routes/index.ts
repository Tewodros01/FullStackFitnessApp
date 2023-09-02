import express from "express";
import userRouter from "./api/user_route.js";
import bookRouter from "./api/book_route.js";
import exerciseRouter from "./api/exercise_route.js";
import workoutRouter from "./api/workout_route.js";
import foodRouter from "./api/food_route.js";

const router: express.Router = express();

router.use("/users", userRouter);
router.use("/books", bookRouter);
router.use("/exercises", exerciseRouter);
router.use("/workouts", workoutRouter);
router.use("/foods", foodRouter);

export default router;
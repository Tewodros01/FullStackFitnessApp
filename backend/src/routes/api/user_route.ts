import express from "express";
import UserController from "../../controllers/user_controller.js";
import { verifyToken } from "../../middleware/auth.js";
import uploadProfilePicture from "../../middleware/user.upload.js";

const userRouter: express.Router = express();

userRouter.get("/", UserController.getAllUser);
userRouter.post("/registor", UserController.createNewUser);
userRouter.put(
  "/update",
  verifyToken,
  uploadProfilePicture.single("profilePicture"),
  UserController.updateUserById
);
userRouter.post("/login", UserController.userLogin);
userRouter.get("/:id", UserController.getUserById);
userRouter.get("/likeExcercise", UserController.getAllUserLikeExcercise);
userRouter.post("/likeExcercise", UserController.userLikeExcercise);
userRouter.get("/likeBook", UserController.getAllUserLikeBook);
userRouter.post("/likeBook", UserController.userLikeBook);
userRouter.get("/likeFood", UserController.getAllUserLikeFood);
userRouter.post("/likeFood", UserController.userLikeFood);

export default userRouter;

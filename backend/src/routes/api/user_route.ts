import express from "express";
import UserController from "../../controllers/user_controller.js";
import { verifyToken } from "../../middleware/auth.js";
import uploadProfilePicture from "../../middleware/user.upload.js";

const userRouter: express.Router = express();

userRouter.post("/registor", UserController.createNewUser);
userRouter.put(
  "/update",
  verifyToken,
  uploadProfilePicture.single("profilePicture"),
  UserController.updateUserById
);
userRouter.post("/login", UserController.userLogin);
userRouter.get("/likeExcercise", UserController.getAllUserLikeExcercise);
userRouter.post("/likeExcercise", UserController.userLikeExcercise);
userRouter.get("/likeBook", UserController.getAllUserLikeBook);
userRouter.post("/likeBook", verifyToken, UserController.userLikeBook);
userRouter.get("/likeFood", UserController.getAllUserLikeFood);
userRouter.post("/likeFood", verifyToken, UserController.userLikeFood);
userRouter.post("/join/:gymId", verifyToken, UserController.joinUserToGym);
userRouter.post("/leave/:gymId", verifyToken, UserController.leaveUserToGym);
userRouter.get("/:id", UserController.getUserById);
userRouter.get("/", UserController.getAllUser);

export default userRouter;

import { Request, Response, NextFunction } from "express";
import jwt from "jsonwebtoken";
import { User, UserStore } from "../models/user.js";
import { IRequest } from "../middleware/auth.js";

class UserController {
  static createNewUser = async (req: Request, res: Response) => {
    try {
      const userStore: UserStore = new UserStore();
      const user: User = {
        full_name: req.body.full_name,
        gender: req.body.gender,
        age: req.body.age,
        email: req.body.email,
        phone_number: req.body.phone_number,
        user_password: req.body.user_password,
      };
      console.log(user);
      const newUser = await userStore.createUser(user);
      let tokenSecret: any = process.env.TOKEN_SECRET;
      const token = jwt.sign({ user: newUser }, tokenSecret);
      newUser.token = token;
      res.json({ message: "Success", data: newUser });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };

  static getAllUser = async (req: Request, res: Response) => {
    try {
      const userStore: UserStore = new UserStore();
      const allUser = await userStore.getAllUsers();
      res.json(allUser);
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static userLogin = async (req: Request, res: Response, next: Function) => {
    try {
      const userStore: UserStore = new UserStore();
      const { email, password } = req.body;
      console.log(email);
      console.log(password);
      const token = await userStore.userLogin(email, password);
      if (token) {
        console.log(token);
        res.json({ message: "Success", data: token });
      } else {
        res
          .status(401)
          .json({ message: "error", error: `Invalid email or password` });
      }
    } catch (error) {
      return next(error);
    }
  };
  static updateUserById = async (
    req: IRequest,
    res: Response,
    next: NextFunction
  ) => {
    try {
      console.log("Update UserById Executed");
      console.log("Req User", req.user);
      const userStore: UserStore = new UserStore();
      // Handle optional profile picture path
      const profile_picture_path = req.file?.path?.replace(/\\/g, "/") || "";
      console.log(`Profile Picture: ${profile_picture_path}`);
      // Extract data from the request body
      const id = req.user?.user_id;
      const user: User = {
        full_name: req.body.full_name,
        gender: req.body.gender,
        birthday: req.body.birthday,
        height: parseInt(req.body.height),
        weight: parseInt(req.body.weight),
        email: req.body.email,
        phone_number: req.body.phone_number,
        aim: req.body.aim,
        activity_extent: req.body.activity_extent,
        profile_picture: profile_picture_path,
      };
      // Calculate the age from the birthday
      if (user.birthday) {
        console.log(`User birthday: Excuted${user.birthday}`);
        const birthDate = new Date(user.birthday);
        const today = new Date();
        const ageInMillis = today.getTime() - birthDate.getTime();
        const ageInYears = Math.floor(
          ageInMillis / (365.25 * 24 * 60 * 60 * 1000)
        ); // Assuming a year has 365.25 days on average
        user.age = ageInYears;
      }
      console.log(`User id: ${id}`);
      console.log(`User Name: ${user.full_name}`);
      console.log(`User birthday: ${user.birthday}`);
      console.log(`User age: ${user.age}`);
      console.log(`User Height: ${user.height}`);
      console.log(`User Weight: ${user.weight}`);
      console.log(`User Aim: ${user.aim}`);
      console.log(`User Activity Extent: ${user.activity_extent}`);
      console.log(`User Age : ${user.age}`);
      // Call the updateUserById method of UserStore (Assuming it returns a promise)
      const result = await userStore.updateUserById(id!, user);
      return res.json({ message: "Success", data: result });
    } catch (error) {
      return next(error); // Pass the error to the next error handling middleware
    }
  };

  static getUserById = async (req: Request, res: Response, next: Function) => {
    try {
      const userStore: UserStore = new UserStore();
      console.log("GetUserById Executed");
      const userWithId = await userStore.getUserById(req.params.id!.toString());
      console.log(`User id: ${userWithId.user_id}`);
      console.log(`User Name: ${userWithId.full_name}`);
      console.log(`userWithId birthday: ${userWithId.birthday}`);
      console.log(`userWithId age: ${userWithId.age}`);
      console.log(`userWithId Height: ${userWithId.height}`);
      console.log(`userWithId Weight: ${userWithId.weight}`);
      console.log(`userWithId Aim: ${userWithId.aim}`);
      console.log(`userWithId Activity Extent: ${userWithId.activity_extent}`);
      console.log(`userWithId Age : ${userWithId.age}`);
      return res.json({ message: "Success", data: userWithId });
    } catch (error) {
      return next(error);
    }
  };
  static userLikeBook = async (req: Request, res: Response) => {
    try {
      const userStore: UserStore = new UserStore();
      const userLikeBook = userStore.userLikeBook(
        req.body.user_id,
        req.body.book_id
      );
      res.json({ message: "Success", data: userLikeBook });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllUserLikeBook = async (req: Request, res: Response) => {
    try {
      const userStore: UserStore = new UserStore();
      const alluserLikeBook = await userStore.getAllUserLikeBook();
      res.json({ message: "Success", data: alluserLikeBook });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static userLikeExcercise = async (req: Request, res: Response) => {
    try {
      const userStore: UserStore = new UserStore();
      const userLikeExcercise = userStore.userLikeExcercise(
        req.body.user_id,
        req.body.exercise_id
      );
      res.json({ message: "Success", data: userLikeExcercise });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllUserLikeExcercise = async (req: Request, res: Response) => {
    try {
      const userStore: UserStore = new UserStore();
      const alluserLikeExcercise = await userStore.getAllUserLikeExcercise();
      res.json({ message: "Success", data: alluserLikeExcercise });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static userLikeFood = async (req: Request, res: Response) => {
    try {
      const userStore: UserStore = new UserStore();
      const userLikeFood = userStore.userLikeFood(
        req.body.user_id,
        req.body.food_id
      );
      res.json({ message: "Success", data: userLikeFood });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
  static getAllUserLikeFood = async (req: Request, res: Response) => {
    try {
      const userStore: UserStore = new UserStore();
      const alluserLikeFood = await userStore.getAllUserLikeFood();
      res.json({ message: "Success", data: alluserLikeFood });
    } catch (err) {
      res.status(400).json(`${err}`);
    }
  };
}

export default UserController;

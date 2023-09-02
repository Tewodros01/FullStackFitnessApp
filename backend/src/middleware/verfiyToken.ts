import { NextFunction, Request, Response } from "express";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const tokenSecret: any = process.env.TOKEN_SECRET;

export const verifyToken = async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  try {
    const authHeader: any = req.headers.authorization;
    const token = authHeader.split(" ")[1];
    const decoded = jwt.verify(token, tokenSecret);
    next();
  } catch (err) {
    res.status(401);
    res.json("Access denied, invalid token");
    return;
  }
};

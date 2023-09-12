import DB from "../configs/db.js";
import bcrypt from "bcrypt";
import dotenv from "dotenv";
import * as auth from "../middleware/auth.js";
import { User } from "./user.js";

dotenv.config();
const pepper: any = process.env.BCRYPT_PASSWORD;
const saltRound: any = process.env.SALT_ROUNDS;

export type Gym = {
  gym_id?: number;
  gym_name: string;
  gym_monthly_payment: number;
  gym_location: string;
  gym_image?: string;
  gym_password: string;
  token?: string;
};

export class GymStore {
  createGym = async (gym: Gym): Promise<Gym | null> => {
    try {
      const conn = await DB.connect();
      const sql = `
        INSERT INTO gym(gym_name, gym_monthly_payment, gym_location, gym_image ,gym_password)
        VALUES($1, $2, $3, $4 ,$5)
        RETURNING *
      `;
      const hash = bcrypt.hashSync(
        gym.gym_password + pepper,
        parseInt(saltRound)
      );
      const result = await conn.query(sql, [
        gym.gym_name,
        gym.gym_monthly_payment,
        gym.gym_location,
        gym.gym_image,
        hash,
      ]);
      conn.release();
      return result.rows[0];
    } catch (error) {
      console.error("Error creating gym:", error);
      return null;
    }
  };

  getAllGym = async (): Promise<Gym[]> => {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM gym";
      const result = await conn.query(sql);
      conn.release();
      return result.rows;
    } catch (error) {
      console.error("Error getting all gyms:", error);
      return [];
    }
  };

  getGymUsers = async (gym_id: number): Promise<User[]> => {
    try {
      const conn = await DB.connect();
      const sql = `
        SELECT u.*
        FROM users u
        INNER JOIN user_gym_membership m ON u.user_id = m.user_id
        WHERE m.gym_id = $1
      `;
      const result = await conn.query(sql, [gym_id]);
      conn.release();
      return result.rows;
    } catch (error) {
      console.error("Error listing gym users:", error);
      return [];
    }
  };
  async gymLogin(gym_name: string, gym_password: string) {
    try {
      const conn = await DB.connect();
      const sql = "SELECT * FROM gym WHERE gym_name = $1";
      const result = await conn.query(sql, [gym_name]);
      const gym: Gym = result.rows[0];
      conn.release();
      if (
        gym &&
        (await bcrypt.compare(gym_password + pepper, gym.gym_password!))
      ) {
        const token = auth.assignAccessTokenToGym(gym);
        console.log(token);
        // Update gym token and save
        gym.token = token;
        return gym;
      }

      return null;
    } catch (error) {
      const errorData = { message: "Log in failed", error: error };
      return errorData;
    }
  }
}

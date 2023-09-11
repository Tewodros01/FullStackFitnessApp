import DB from "../configs/db.js";
import { User } from "./user.js";

export type Gym = {
  gym_id?: number;
  gym_name: string;
};
export class GymStore {
  createGym = async (gym_name: string): Promise<Gym | null> => {
    try {
      const conn = await DB.connect();
      const sql = "INSERT INTO gym(gym_name) VALUES($1) RETURNING *";
      const result = await conn.query(sql, [gym_name]);
      return result.rows[0];
    } catch (error) {
      console.error("Error creating gym:", error);
      return null;
    }
  };
  listGymUsers = async (gymId: number): Promise<User[]> => {
    try {
      const conn = await DB.connect();
      const sql = `
        SELECT u.*
        FROM users u
        INNER JOIN user_gym_membership m ON u.id = m.user_id
        WHERE m.gym_id = $1
      `;
      const result = await conn.query(sql, [gymId]);
      conn.release();
      return result.rows;
    } catch (error) {
      console.error("Error listing gym users:", error);
      return [];
    }
  };
  updateUserPaymentStatus = async (
    userId: number,
    isPaid: boolean
  ): Promise<User | null | undefined> => {
    try {
      const conn = await DB.connect(); // Assuming DB.connect() returns a connection from the pool
      // Prepare the SQL query to update the user
      const sql = "UPDATE users SET is_paid = $1 WHERE id = $2";
      // Execute the update query and await the result
      const result = await conn.query(sql, [
        [isPaid, userId], // This may be undefined if no profile_picture is provided
      ]);

      // If a row was affected, return the updated user, otherwise return null
      if (result.rowCount > 0) {
        return result.rows[0];
      } else {
        return null;
      }
    } catch (error) {
      console.error("Error updating user payment status:", error);
    }
  };
}

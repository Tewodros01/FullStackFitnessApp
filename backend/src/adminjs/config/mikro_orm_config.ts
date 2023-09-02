import { Options } from "@mikro-orm/postgresql";
import { User } from "../entity/user.entity.js";
import { Book } from "../entity/book.entity.js";

export const config: Options = {
  entities: [User, Book],
  dbName: "fitness_db",
  type: "postgresql",
  user: "postgres",
  password: "tewodros",
  clientUrl: "postgresql://localhost:5432",
};

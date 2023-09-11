import { MikroORM } from "@mikro-orm/core";
import { Options } from "@mikro-orm/postgresql";
import { User } from "../entity/user.entity.js";
import { Book } from "../entity/book.entity.js";
import { Exercise } from "../entity/exercise.entity.js";
import { Workout } from "../entity/workout.entity.js";
import { ExerciseCategory } from "../entity/exercis_ceategory.entity.js";

const config: Options = {
  entities: [User, Book, Exercise, Workout, ExerciseCategory],
  dbName: "fitness_db",
  type: "postgresql",
  user: "postgres",
  password: "tewodros",
  clientUrl: "postgresql://localhost:5432",
};

// Initialize MikroORM
const orm = await MikroORM.init(config);

const adminOptions = {
  resources: [
    {
      resource: { model: User, orm },
      options: {},
    },
    {
      resource: {
        model: Book,
        orm,
        options: {
          properties: {
            properties: {
              bookTitle: { type: "string" },
              bookDescription: { type: "text" },
              bookAuthorName: { type: "string" },
              bookThumbnail: { type: "file" }, // Use 'file' for file uploads
              bookFilePath: { type: "file" },
            },
          },
        },
      },
    },
    {
      resource: { model: Exercise, orm },
      options: {},
    },
    {
      resource: { model: Workout, orm },
      options: {},
    },
    {
      resource: { model: ExerciseCategory, orm },
      options: {},
    },
  ],
};

export default adminOptions;

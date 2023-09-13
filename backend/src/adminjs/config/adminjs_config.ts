import { MikroORM } from "@mikro-orm/core";
import { Options } from "@mikro-orm/postgresql";
import { User } from "../entity/user.entity.js";
import { Book } from "../entity/book.entity.js";
import { Exercise } from "../entity/exercise.entity.js";
import { Workout } from "../entity/workout.entity.js";
import { ExerciseCategory } from "../entity/exercis_ceategory.entity.js";
import CustomFileUpload from "./CustomFileUpload.jsx";

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
            bookTitle: { type: "string" },
            bookDescription: { type: "text" },
            bookAuthorName: { type: "string" },
            bookThumbnail: {
              type: "file",
              columnType: "file", // Ensure you set the columnType to "file"
              isVisible: { list: true, show: true, edit: true },
              components: {
                edit: CustomFileUpload, // Use your custom file upload component
              },
            },
            bookFilePath: {
              type: "file",
              columnType: "file", // Ensure you set the columnType to "file"
              isVisible: { list: true, show: true, edit: true },
              components: {
                edit: CustomFileUpload, // Use your custom file upload component
              },
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

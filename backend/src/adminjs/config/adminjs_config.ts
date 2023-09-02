import { MikroORM } from "@mikro-orm/core";
import { User } from "../entity/user.entity.js";
import { Book } from "../entity/book.entity.js";
import { config } from "../config/mikro_orm_config.js";

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
  ],
};

export default adminOptions;

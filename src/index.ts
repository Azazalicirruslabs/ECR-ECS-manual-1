import express from "express";
import router from "./routes/router";

const app = express();
const PORT = process.env.PORT ?? 8000;

app.use("/", router);

app.listen(Number(PORT), "0.0.0.0", () =>
  console.log(`Server Started on PORT ${PORT} 🎉`)
);


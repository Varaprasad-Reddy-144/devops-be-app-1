require("dotenv").config();
const bodyParser = require("body-parser");
const cookieParser = require("cookie-parser");
const express = require("express");

const app = express();

app.use(cookieParser());
app.use(bodyParser.json({ limit: "5mb" }));
app.use(bodyParser.urlencoded({ extended: true }));

app.get("/health", async (req, res, next) => {
    res.status(200).json({
        status: "OK",
    })
});


app.get("/data", async (req, res, next) => {
  res.status(200).json({
    success: true,
    data: true,
  })
});

app.use((req, res, next) => {
    res.status(404).json({ error: "Not Found"})
});

const main = () => {
   const port = process.env.PORT || 8000;
   app.listen(port, () => {
     console.log(`Server is running on port ${port}`);
   })
}

main();
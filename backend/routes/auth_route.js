import express from "express";
import bcrypt from "bcrypt";
import jwt from "jsonwebtoken";
import dotenv from "dotenv";
import db from "../database.js"; 

dotenv.config();
const router = express.Router();

// Register a New User
router.post("/register", async (request, respond) => {
  const { username, email, password } = request.body;

  if (!username || !email || !password) {
    return respond.status(400).json({ message: "All fields are required." });
  }

  try {
    const hashedPassword = await bcrypt.hash(password, 10);
    await db.run("INSERT INTO USERS (USERNAME, EMAIL, HASHED_PASS) VALUES (?, ?, ?)", 
                 [username, email, hashedPassword]);

    respond.status(201).json({ message: "User registered successfully!" });
  } catch (error) {
    respond.status(500).json({ message: "Error registering user.", error });
  }
});

// User Login
router.post("/login", async (request, respond) => {
  const { email, password } = request.body;

  if (!email || !password) {
    return respond.status(400).json({ message: "Email and password are required." });
  }

  try {
    const user = await db.get("SELECT * FROM USERS WHERE EMAIL = ?", [email]);
    if (!user) {
      return respond.status(400).json({ message: "User not found." });
    }

    const passwordMatch = await bcrypt.compare(password, user.HASHED_PASS);
    if (!passwordMatch) {
      return respond.status(401).json({ message: "Incorrect password." });
    }

    const token = jwt.sign({ userId: user.ID }, process.env.JWT_SECRET, { expiresIn: "2h" });
    respond.json({ token, message: "Login successful!" });
  } catch (error) {
    respond.status(500).json({ message: "Error logging in.", error });
  }
});

export default router;

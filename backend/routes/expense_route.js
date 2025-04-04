import express from "express"; 
import authMiddleware from "../middleware/auth_middleware.js";
import db from "../database.js";

const router = express.Router();

router.post("/add", authMiddleware, async (request, respond) => {
  const { amount, category, date, notes } = request.body;

  if (!amount || !category || !date) {
    return respond.status(400).json({ message: "Amount, category, and date are required." });
  }

  try {
    await db.run(
      "INSERT INTO EXPENSE (USER_ID, AMOUNT, CATEGORY, DATE, NOTES) VALUES (?, ?, ?, ?, ?)",
      [request.userId, amount, category, date, notes]
    );
    respond.status(201).json({ message: "Expense added successfully!" });
  } catch (error) {
    respond.status(500).json({ message: "Error adding expense.", error });
  }
});

router.get("/expense-list", authMiddleware, async (request, respond) => {
  try {
    const expenses = await db.all("SELECT * FROM EXPENSE WHERE USER_ID = ?", [request.userId]);
    respond.json(expenses);
  } catch (error) {
    respond.status(500).json({ message: "Error retrieving expenses.", error });
  }
});

export default router;

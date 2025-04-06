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

router.get("/daily-summary", authMiddleware, async (request, respond) => {
  const { month } = request.query; 
  
  if (!month || !/^\d{4}-\d{2}$/.test(month)) {
    return respond.status(400).json({ message: "Invalid or missing month. Use format YYYY-MM." });
  }

  const startDate = `${month}-01`;
  const endDate = `${month}-31`; 

  try {
    const query = `
      SELECT DATE(DATE) as day, SUM(AMOUNT) as total
      FROM EXPENSE
      WHERE USER_ID = ?
        AND DATE >= ?
        AND DATE <= ?
      GROUP BY DATE(DATE)
      ORDER BY DATE(DATE)
    `;
    
    const rows = await db.all(query, [request.userId, startDate, endDate]);

    // Convert to object like { "2025-04-01": 25.0 }
    const dailySpending = {};
    for (const row of rows) {
      dailySpending[row.day] = row.total;
    }

    respond.json(dailySpending);

  } catch (error) {
    console.error(error);
    respond.status(500).json({ message: "Error fetching daily summary.", error });
  }
});


export default router;

import express from "express"; 
import dotenv from "dotenv"; 
import cors from "cors"; 
import authRoutes from "./routes/auth_route.js";
import expenseRoutes from "./routes/expense_route.js";

dotenv.config();

const app = express(); 
const PORT = process.env.PORT;

// Middleware to parse JSON requests
app.use(express.json());

// Allow frontend to make API requests
app.use(cors()); 

app.use("/auth", authRoutes); 
app.use("/expense", expenseRoutes); 

app.get("/", (request, respond) => {
    respond.send("Server is running!");
});

app.listen(PORT, () => {
    console.log(`Server running on http://localhost:${PORT}`);
});

import jwt from "jsonwebtoken";
import dotenv from "dotenv";

dotenv.config();

const authMiddleware = (request, respond, next) => {
  const token = request.header("Authorization")?.split(" ")[1];

  if (!token) {
    return respond.status(403).json({ message: "Access denied. No token provided." });
  }

  try {
    const decoded = jwt.verify(token, process.env.JWT_SECRET);
    request.userId = decoded.userId;
    next();
  } catch (error) {
    respond.status(401).json({ message: "Invalid token." });
  }
};

export default authMiddleware;

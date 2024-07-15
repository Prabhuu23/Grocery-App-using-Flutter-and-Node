const express = require('express');
const bodyParser = require('body-parser');
const helmet = require('helmet');
const morgan = require('morgan');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(helmet());
app.use(morgan('dev'));
app.use(cors());



// Define the MongoDB connection URL
// const DB_URL = 'mongodb://localhost:27017/GroceryApp';

// // Connect to MongoDB
// mongoose.connect(DB_URL, { useNewUrlParser: true, useUnifiedTopology: true })
//   .then(() => {
//     // Connection successful
//     console.log('Connected to MongoDB');

//     // Proceed with database operations here
//   })
//   .catch((error) => {
//     // Connection error
//     console.error('Error connecting to MongoDB:', error.message);
//   });




// mongoose.connect("mongodb+srv://khadkaprabhu909:mpwjCSM3kG0Y4ScR@cluster0.da8tdbp.mongodb.net/"); 
mongoose.connect("mongodb://127.0.0.1:27017");
// Import user routes
const UserRoutes = require('./routes/user_routes');
// Use user routes
app.use("/api/user", UserRoutes);

const CategoryRoutes = require('./routes/category_routes');
app.use("/api/category", CategoryRoutes);

const ProductRoutes = require('./routes/product_routes');
app.use("/api/product", ProductRoutes);

const PORT = 5000;
app.listen(PORT, () => console.log(`Server started at PORT:${PORT}`));

//imports from packages
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');

//imports from other files
const authRouter = require('./routes/auth');
const adminRouter = require('./routes/admin');
const productRouter = require('./routes/products');
const userRouter = require('./routes/user');

//initializations
const PORT = 3000;
const app = new express();
const DBUrl = "mongodb+srv://ahosari20:a01129376126@cluster0.frvxonk.mongodb.net/?retryWrites=true&w=majority";

//middleware
app.use(express.json());
app.use(cors());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

//connections
mongoose.connect(DBUrl).then(
    ()=>{
        console.log('Connection Successful');
    }
).catch((e)=>{
    console.log(e);
});

//start server
app.listen(PORT, "0.0.0.0", () =>{
    console.log(`connected at port ${PORT}`);
});
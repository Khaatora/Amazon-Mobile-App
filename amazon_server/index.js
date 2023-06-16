//imports from packages
const express = require('express');
const mongoose = require('mongoose');

//imports from other files
const authRouter = require('./routes/auth');

//initializations
const PORT = 3000;
const app = express();
const DBUrl = "DBUrl";

//middleware
app.use(express.json());
app.use(authRouter);

//connections
mongoose.connect(DBUrl).then(
    ()=>{
        console.log('Connection Successful');
    }
).catch((e)=>{
    console.log(e);
});

//start server
app.listen(PORT, ip, () =>{
    console.log(`connected at port ${PORT}`);
});
const express = require('express');
const User = require('../models/user');
const bcryptjs = require('bcryptjs');
const jwt = require('jsonwebtoken');
const auth = require('../middlewares/auth');

const authRouter = express.Router();

//Sign up route
authRouter.post('/api/signup', async (req, res)=>{
    const {email, password, name, type} = req.body;
    try{
        const existingUser = await User.findOne({email});
        if(existingUser){
            return res.status(400).json({msg: "User with same email already exists"});
        }
        const hashedPassword = await bcryptjs.hash(password, 8);

        let user = new User({
            email,
            password : hashedPassword,
            name,
            type,
        });
        user = await user.save();
        console.log(user);
        res.json(user);
        //  post that data in database
        //  return that data to the user
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

//Sign in route
authRouter.post('/api/signin', async (req, res)=>{
    try{
        const {email, password} = req.body;
        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg: "invalid credentials"});
        }
        const matches = await bcryptjs.compare(password, user.password);
        if(!matches){
            return res.status(400).json({msg: "invalid password"});
        }
        const token = jwt.sign({id: user._id}, "passwordKey");
        console.log(`>>>>>>>>>${user._id}<<<<<<<<<<`);
        res.json({token, ...user._doc});
    }catch (e){
        res.status(500).json({error: e});
    }
});

authRouter.post('/api/validate-token', async (req, res)=>{
    try{
        const token = req.header('x-auth-token');
        console.log(`token: ${token}`);
        if(!token) return res.json(false);
        const verified = jwt.verify(token, 'passwordKey');        
        if(!verified) return res.json(false);
        const user = await User.findById(verified.id);
        if(!user) return res.json(false);
        console.log(`>>>>>>>>>${user._id}<<<<<<<<<<`);
        res.json(true);
    }catch (e){
        res.status(500).json({error: e});
    }
});

authRouter.get('/api/', auth, async (req, res) =>{
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
});

module.exports = authRouter;
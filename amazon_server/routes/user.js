const express = require('express');
const userRouter = express.Router();
const auth = require('../middlewares/auth');
const {Product} = require('../models/product');
const User = require('../models/user');
const Order = require('../models/order');

userRouter.post('/api/add-to-cart', auth, async  (req, res)=> {
  try{
      const {_id} = req.body;
      const product = await Product.findById(_id);
      let user = await User.findById(req.user);
      if(user.cart.length == 0){
        user.cart.push({product, quantity: 1});
      } else {
        let isProductFound = false;
        for(let i=0; i<user.cart.length; i++){
          console.log(`${user.cart[i].product._id}`);
          if(user.cart[i].product._id.equals(product._id)){
            isProductFound = true;
          }
        }
        if(isProductFound){
          let targetProduct = user.cart.find((cartItem) => cartItem.product._id.equals(product._id));
          targetProduct.quantity+=1;
        }else{
          user.cart.push({product, quantity:1});
        }
      }
      user = await user.save();
      res.json({data : user});
  }catch(e){
    console.log(`${e.message}`);
      res.status(500).json({error: e.message});
  }
});

userRouter.delete('/api/remove-from-cart/:id', auth, async  (req, res)=> {
  try{
      const {id} = req.params;
      const product = await Product.findById(id);
      let user = await User.findById(req.user);
        for(let i=0; i<user.cart.length; i++){
          console.log(`${user.cart[i].product._id}`);
          if(user.cart[i].product._id.equals(product._id)){
            if(user.cart[i].quantity == 1){
              user.cart.splice(i, 1);
            } else{
              user.cart[i].quantity -=1;
            }
            break;
          }
        }
      user = await user.save();
      res.json({data : user});
  }catch(e){
    console.log(`${e.message}`);
      res.status(500).json({error: e.message});
  }
});

userRouter.post('/api/update-user-address', auth, async  (req, res)=> {
  try{
      const {address} = req.body;
      let user = await User.findById(req.user);
      user.address = address;
      user = await user.save();
      res.json({data : user});
  }catch(e){
    console.log(`${e.message}`);
      res.status(500).json({error: e.message});
  }
});

userRouter.post('/api/order', auth, async  (req, res)=> {
  try{
      const {cart, totalPrice, address} = req.body;
      let products = [];
      
      for(let i =0; i< cart.length; i++){
        let product = await Product.findById(cart[i].product._id);
        if(product.quantity >= cart[i].quantity){
          product.quantity -= cart[i].quantity;
          products.push({product, quantity: cart[i].quantity});
          await product.save();
        } else{
          return res.status(400).json({msg: `${product.name} is out of stock!`});
        }
      }

      let user = await User.findById(req.user);
      user.cart = [];
      user = await user.save();
      console.log("creating order");
      let order = new Order({
        products,
        totalPrice,
        address,
        userId: req.user,
        orderedAt: new Date().getTime(),
      });
      console.log(order.toString());
      order = await order.save();
      res.json(order);
  }catch(e){
    console.log(`${e.message}`);
      res.status(500).json({error: e.message});
  }
});

userRouter.get('/api/orders/me', auth, async  (req, res)=> {
  try{
      const order = await Order.find({userId: req.user});
      res.json({data : order});
  }catch(e){
    console.log(`${e.message}`);
      res.status(500).json({error: e.message});
  }
});

module.exports = userRouter;
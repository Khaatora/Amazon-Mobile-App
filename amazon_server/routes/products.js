const express = require('express');
const productRouter = express.Router();
const {Product} = require('../models/product');
const auth = require('../middlewares/auth');


productRouter.get('/api/products', auth,async  (req, res)=> {
  try{
      const products = await Product.find({category: req.query.category});
      res.json({
          data: products,
      });
  }catch(e){
    console.log(`${e.message}`);
      res.status(500).json({error: e.message});
  }
});

productRouter.get('/api/products/search/:query', auth,async  (req, res)=> {
  try{
      const products = await Product.find({
        name : {
          $regex: req.params.query, $options: "i"
        }
      });
      res.json({
          data: products,
      });
  }catch(e){
    console.log(`${e.message}`);
      res.status(500).json({error: e.message});
  }
});

productRouter.post('/api/rate-product', auth, async  (req, res)=> {
  try{
      const {_id, rating} = req.body;
      console.log(`id: ${_id}, rating: ${rating}`);
      let product = await Product.findById(_id);
      for(let i=0; i<product.ratings.length; i++){
        if(product.ratings[i].userId == req.user){
          product.ratings.splice(i, 1);
          break;
        }
      }
      const ratingSchema = {
        userId: req.user,
        rating,
      }
      product.ratings.push(ratingSchema);
      product = await product.save();
      res.json({
          data: product,
      });
  }catch(e){
    console.log(`${e.message}`);
      res.status(500).json({error: e.message});
  }
});

productRouter.get('/api/deal-of-the-day', auth, async  (req, res)=> {
  try{
      const products = await Product.find({});
      products.sort((a, b) =>{
        let aSum = 0;
        let bSum = 0;
        for(let i =0; i<a.ratings.length; i++){
          aSum+= a.ratings[i].rating;
        }
        for(let i =0; i<b.ratings.length; i++){
          bSum+= b.ratings[i].rating;
        }
        return aSum < bSum ? 1 : -1;
      });
      console.log("done");
      res.json({
          data: products[0],
      });
  }catch(e){
    console.log(`${e.message}`);
      res.status(500).json({error: e.message});
  }
});

module.exports = productRouter;
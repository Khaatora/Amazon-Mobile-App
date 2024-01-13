const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const {Product} = require('../models/product');
const Order = require('../models/order');
const Ratings = require('../models/ratings');

// Add Product
adminRouter.post('/api/admin/add-product', admin, async  (req, res)=> {
    try{
        const {name, description, images, quantity, price, category} = req.body;
        let product = new Product({
            name,
            description,
            images,
            quantity,
            price,
            category,
            ratings: []
        });
        product = await product.save();
        res.json(product);
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

// Get All Products

adminRouter.get('/api/admin/get-products', admin, async  (req, res)=> {
    try{
        let products = await Product.find({});
        res.json({
            data: products,
        });
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

// Delete A Products

adminRouter.post('/api/admin/delete-product', admin, async  (req, res)=> {
    try{
        const {_id} = req.body;
        let product = await Product.findByIdAndDelete(_id);
        res.json(product);
    }catch(e){
        console.log(e.message);
        res.status(500).json({error: e.message});
    }
});

adminRouter.get('/api/admin/get-orders', admin, async  (req, res)=> {
    try{
        let orders = await Order.find({});
        res.json({
            data: orders,
        });
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

adminRouter.post('/api/admin/change-order-status', admin, async  (req, res)=> {
    try{
        let {orderId, status} = req.body;
        let order = await Order.findById(orderId);
        console.log(order.status.toString());
        order.status = status;
        order = await order.save();
        res.json({
            data: order,
        });
    }catch(e){
        res.status(500).json({error: e.message});
    }
});

adminRouter.get('/api/admin/analytics', admin, async  (req, res)=> {
    try{
        const orders = await Order.find({});
        let totalEarnings = 0;
        for(let i=0; i<orders.length; i++){
            let order = orders[i];
            for(let j=0; j<order.products.length; j++){
                totalEarnings += order.products[j].quantity * order.products[j].product.price;
            }
        }
        let mobileEarnings = await fetchCategoryWiseproduct("Mobiles");
        let essentialsEarnings = await fetchCategoryWiseproduct("Essentials");
        let appliancesEarnings = await fetchCategoryWiseproduct("Appliances");
        let booksEarnings = await fetchCategoryWiseproduct("Books");
        let fashionEarnings = await fetchCategoryWiseproduct("Fashion");

        let earnings = {
            totalEarnings,
            mobileEarnings,
            essentialsEarnings,
            appliancesEarnings,
            booksEarnings,
            fashionEarnings,
        }

        res.json({data: earnings});
    }catch(e){
        
        console.log(e.toString());
        res.status(500).json({error: e.message});
    }
});

async function fetchCategoryWiseproduct(category){
    let categoryOrders = await Order.find({
        "products.product.category": category,
    });
    let earnings = 0;
    for(let i=0; i<categoryOrders.length; i++){
        let order = categoryOrders[i];
        for(let j=0; j<order.products.length; j++){
            earnings += order.products[j].quantity * order.products[j].product.price;
        }
    }
    return earnings;
}

module.exports = adminRouter;
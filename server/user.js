const express = require("express");
const userRouter=express.Router();

const auth=require("./middlewares/auth");
const { Product } = require("./model/product");

const User=require("./model/user");
const Order = require("./model/order");

userRouter.post("/api/add-to-cart",auth,async(req,res)=>{
    
    try{
    const {id}=req.body;
     
   
    const product=await Product.findById(id);
    if(!product){
        return res.status(404).json({error:"Product not found"});
    }
    let user=await User.findById(req.user);
    if (!user) {
        return res.status(404).json({ error: "User not found" });
      }
    

    if(user.cart.length==0){
        user.cart.push({product,quantity:1});
    }else{
        let isProductFound=false;
        for(let i=0;i<user.cart.length;i++){
            if(user.cart[i].product._id.equals(product._id)){
                isProductFound=true;
            }
        }
        if(isProductFound){
            let cartProduct=user.cart.find((cartProduct)=>cartProduct.product._id.equals(product._id));
            cartProduct.quantity+=1;
        }else{
            user.cart.push({product,quantity:1});
        }
    }

    user=await user.save();
    res.json(user);
    }catch(e){
        res.status(500).json({error:e.message});
    }
    });
   

    userRouter.delete("/api/remove-from-cart/:id",auth,async(req,res)=>{
    
        try{
        const {id}=req.params;
         
       
        const product=await Product.findById(id);
        
        let user=await User.findById(req.user);
        
        
    
        if(user.cart.length==0){
           
        }else{
           
            for(let i=0;i<user.cart.length;i++){
                if(user.cart[i].product._id.equals(product._id)){

                    if(user.cart[i].quantity==1){
                        user.cart.splice(i,1);
                    }else{
                        user.cart[i].quantity-=1;
                    }
                }
            }
        
        }
    
        user=await user.save();
        res.json(user);
        }catch(e){
            res.status(500).json({error:e.message});
        }
        });

        userRouter.post("/api/save-user-address",auth,async(req,res)=>{
            try{
                const{address}=req.body;
                let user=await User.findById(req.user);
                user.address=address;
                user=await user.save();
                res.json(user);

            }catch(error){
                res.status(500).json({error:error.message});
            }
        });
       
userRouter.post("/api/order",auth,async(req,res)=>{
    try{
        const {cart,total,address}=req.body;
        let products=[];
        for(let i=0;i<cart.length;i++){
            let product =await Product.findById(cart[i].product._id);
            if(product.quantity>=cart[i].quantity){
                product.quantity-=cart[i].quantity;
                products.push({
                    product,quantity:cart[i].quantity
                });
                await product.save();
            }else{
                return res.status(400).json({msg:`${product.name} is out of stock!`});
            }
        }
        let order =new Order({
            products,total,address,userId:req.user,orderedAt:new Date().getTime(),
        });
        order =await order.save();
        let user=await User.findById(req.user);
        user.cart=[];
        user=await user.save();
        res.json(order);

    }catch(error){
res.status(500).json({error:error.message});
    }
});
    
userRouter.get("/api/myorders",auth,async(req,res)=>{
    try{
const orders=await Order.find({userId:req.user});

res.json(orders);

    }catch(e){
        res.status(500).json({e:e.message});

    }
});
userRouter.post("/api/switch-to-seller", auth, async (req, res) => {
    try {
        const { newType } = req.body; // Get new type (either 'seller' or 'user') from the request

        // Validate the newType
        if (!newType || (newType !== "seller" && newType !== "user")) {
            return res.status(400).json({ message: "Invalid user type provided." });
        }

        // Find the user by ID
        let user = await User.findById(req.user);
        if (!user) {
            return res.status(404).json({ message: "User not found." });
        }

        // Update user type
        user.type = newType;
        await user.save();

        // Send success response
        res.json({ message: `User type updated to ${newType}.`, user });
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});


    
    
    module.exports =userRouter;
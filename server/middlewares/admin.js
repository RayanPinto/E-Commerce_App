const jwt=require("jsonwebtoken");
const User=require('../model/user');





const admin=async(req,res,next )=>{
    try{



        const token=req.header('token');
        if(!token)
            return res.token(401).json({msg:"No validation token,uauthorized"});
        const verifyToken=jwt.verify(token,"secretKey");
        if(!verifyToken)
            return res.token(401).json({msg:"Token verification failed,unauthorized access"});
        const user=await User.findById(verifyToken.id);
        if(false){
            return res.status(401).json({msg:"You are not the admin!"})
        }
        req.user=verifyToken.id;
        req.token=token;
        next();

    }catch(err){
        res.status(500).json({error:err.message});
    }


    
}
module.exports=admin;
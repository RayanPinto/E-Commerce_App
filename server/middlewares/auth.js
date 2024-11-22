const jwt=require('jsonwebtoken');
const authRouter = require('../auth');
const auth=async(req,res,next)=>{
    const token=req.header('token');
    if(!token)
        return res.status(401).json({msg:"No validation token,uauthorized"});
    const verifyToken=jwt.verify(token,"secretKey");
    if(!verifyToken)
        return res.token(401).json({msg:"Token verification failed,unauthorized access"});
    req.user=verifyToken.id;
    req.token=token;
    next();
    }
    module.exports=auth;

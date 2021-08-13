const {dbCon} = require("../config/dbConfig");

const checkAuth = (req, res, next) => {
    if (req.isAuthenticated()) {
      return next();
    } else {
      res.send({
        message: "Please log in to access this page.",
        success: false,
      });
    }
  };

  const getUserByUsername = (username) => {
    return new Promise((resolve,reject)=>{
      dbCon.query("SELECT username,password,user_id AS id FROM users WHERE username = ?",[username],(err,res)=>{
        if(err) reject(err);
        if(res[0] === undefined){
          resolve(null)
        }else{
          resolve(res[0])
        }    
      })
    })
  }

  const getUserById = (id) => {
    return new Promise((resolve,reject)=>{
      dbCon.query("SELECT username,password,user_id AS id FROM users WHERE user_id = ?",[id],(err,res)=>{
        if(err) reject(err);
        resolve(res[0]);
      })
    })
  }

  module.exports={
      getUserById,
      getUserByUsername,
      checkAuth
  }
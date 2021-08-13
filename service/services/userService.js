const { dbCon } = require("../config/dbConfig");
const bcrypt = require("bcrypt");
const passport = require("passport");

class UserOperations {
  constructor() {}

  static logIn(request, response, next) {
    //log in logic
    return new Promise((resolve, reject) => {
      passport.authenticate("local", function (err, user, info) {
        if (err) {
          reject(next(err));
        }
        if (!user) {
          resolve({
            success: false,
            message: info.message,
          });
        } else {
          request.logIn(user, function (err) {
            if (err) {
              throw err + " in request.logIn function!";
            }else{
              resolve({
                success: true,
                message: info.message,
              });
            }
          });
        }
      })(request, response, next);
    });
  }

  static logOut(request) {
    // sign out logic
    return new Promise((resolve,reject)=>{
        request.session.destroy();  
        resolve({
            success:true,
            message:'Logged out successfully!'
        })
    })
  }

  static register(username, password, email) {
    // method to register
    return new Promise((resolve, reject) => {
      const saltRounds = 10;
      bcrypt.genSalt(saltRounds, function (err, salt) {
        bcrypt.hash(password, salt, function (err, hash) {
          if(err) reject(err);
          dbCon.query(
            "CALL register_user(?,?,?)",
            [username, hash, email],
            (err, res) => {
              if (err) reject(err);
              resolve(res);
            }
          );
        });
      });
    });
  }
}

module.exports = {
  UserOperations,
};

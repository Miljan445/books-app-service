const mysql = require("mysql");
const procces_env = require('../ENV/process_env')

const dbCon = mysql.createConnection({
    host: "localhost",
    user: procces_env.username,
    password: procces_env.password,
    database: procces_env.dbName,
    port: procces_env.dbPort
  });

dbCon.connect((err)=>{
    if(err) throw err;
    console.log('Connection to db made');
})


module.exports = {
  dbCon:dbCon
}
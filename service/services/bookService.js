const { dbCon } = require("../config/dbConfig");

class BookHandler {
  constructor() {}

  static getBooks() {
    // method to retrive all books
    // procedure wrote
    return new Promise((resolve, reject) => {
      dbCon.query("CALL get_all_books();", (err, res) => {
        if (err) reject(err);
        resolve(res[0]);
      });
    });
  }

  static addBooks(request) {
    // method to add books
    return new Promise((resolve,reject)=>{
      dbCon.query("CALL add_book_to_stock(?,?,?,?,?,?,?)",[request.body.user_id,request.body.title,request.body.price,request.body.year,request.body.description,request.body.url,request.body.quantity],(err,res)=>{
        if(err) reject(err);
        resolve(res)
      })
    })
    // procedure wrote
  }

  static deleteBooks() {
    // method to remove books
  }

  static getUsersBooks() {
    // method to retrive books from specific user
    // procedure wrote
  }

  static orderBook(
    book_id,
    quantity,
    adress,
    name,
    surrname,
    ordered_from,
    phone_number
  ) {
    // method to order books
    return new Promise((resolve, reject) => {
      dbCon.query(
        "CALL book_order(?,?,?,?,?,?,?)",
        [book_id, quantity, adress, name, surrname, ordered_from, phone_number],
        (err, res) => {
          if (err) reject(err);
          resolve(res);
        }
      );
    });
  }
}

module.exports = {
  BookHandler,
};

const express = require("express");
const app = express();
const procces_env = require("./ENV/process_env");
const cors = require('cors');
const session = require('express-session');
const passport = require("passport");
const { initialize } = require("./config/passport-config");
const {getUserById,getUserByUsername,checkAuth} = require("./utils/utils");


// PASSPORT INITIALIZATION
initialize(passport,getUserByUsername,getUserById);
// PASSPORT INITIALIZATION
// USES
app.use(cors({
  origin: "http://127.0.0.1:3000",
  methods: ['POST', 'GET'],
  credentials: true
}))
app.use(express.json());
app.use(session({
  secret: 'secret',
  resave: true,
  saveUninitialized: true,
}));
app.use(passport.initialize());
app.use(passport.session());
// USES
// CLASESS
const {BookHandler} = require("./services/bookService");
const {UserOperations} = require("./services/userService");
// CLASSES
app.get("/getBooks", (request, response) => {
  BookHandler.getBooks().then(books=>{
    response.send(books);
  }).catch(err=>{
    console.log("Book fetching operation faield due to " + err);
  });
});

app.post("/logIn",(request,response, next)=>{
  UserOperations.logIn(request, response, next).then((data) => {
    return response.json(data);
  }).catch(err=>{
    throw 'Log in failed , ' + err;
  })
})

app.post("/logOut",(request,response)=>{
  UserOperations.logOut(request).then(data=>{
    response.json(data);
  })
})

app.post("/register",(request,response)=>{
  UserOperations.register(request.body.username,request.body.password,request.body.email).then(res=>{
    response.send(res[0]);
  }).catch(err=>{
    throw "Register failed due to " + err;
  })
})

app.post("/orderBook",checkAuth,(request,response)=>{
    BookHandler.orderBook(request.body.book_id,request.body.quantity,request.body.adress,request.body.name,request.body.surrname,request.body.ordered_from,request.body.phone_number).then(res=>{
      response.send(res[0])
    }).catch(err=>{
      throw "Book order operation failed due to " , err;
    })
})

app.post("/addBook",checkAuth,(request,response)=>{
  console.log('add book request ' , request.body)
  BookHandler.addBooks(request).then(data=>{
    response.send(data);
  }).catch(err=>{
    throw 'Book ordering failed due to ' + err;
  })
})

app.listen(procces_env.port, () => {
  console.log(`Server listening on http://localhost:${procces_env.port}`);
});

const localStrategy = require("passport-local").Strategy;
const bcrypt = require("bcrypt");

const initialize = (passport, getUserByUsername, getUserById) => {
  const authUser = async (username, password, done) => {
    try {
      const user = await getUserByUsername(username);
      if (user === null) {
        return done(null, false, { message: "No user with that username" });
      } else {
        bcrypt.compare(password, user.password, (err, isMatch) => {
          if(err) throw err + "in bcrypt compare!";
          if (isMatch) {
            return done(null, user, { message: "Logged in!" });
          } else {
            return done(null, false, { message: "password inccorect" });
          }
        });
      }
    } catch (err) {
      throw err + " in authUser function!";
    }
  };
  // OVA FUNKIJCA SE POZIVA IZ USEROPERATIOS LOG IN-A , I TAMO SE HVATAJU PORUKE I SUCCES IZ AUTHUSER FUNCKIJE
  passport.use(new localStrategy({ usernameField: "username" , passwordField: "password"}, authUser));
  // OVO UPISUJE USERA U SESIJU PRI LOGIN-U, TACNIJE NJEGOV ID KOJI KASNIJE DESIRIALIZE USER KORISTI
  passport.serializeUser((user, done) => {
    return done(null, user.id);
  });
  // DESIRIALIZE TRAZI ID KOJI JE SERIALIZE UPISAO U SESSIJU I ONDA TRAZI PO TOM ID-JU U BAZI DA LI POSTOJI TAJ USER
  passport.deserializeUser((id, done) => {
    return done(null, getUserById(id));
  });
};

module.exports = { initialize };

  // Your web app's Firebase configuration
  // For Firebase JS SDK v7.20.0 and later, measurementId is optional
  var firebaseConfig = {
    apiKey: "AIzaSyAzclqpbdXwF_ChrN3vX0z9mrxmRdORRYg",
    authDomain: "cbs-ngo.firebaseapp.com",
    databaseURL: "https://cbs-ngo.firebaseio.com",
    projectId: "cbs-ngo",
    storageBucket: "cbs-ngo.appspot.com",
    messagingSenderId: "875415534364",
    appId: "1:875415534364:web:5bf2e0837d9b19ec7918d9",
    measurementId: "G-Q893RCCJKN"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  firebase.analytics();
  function signin(){
      var userEmail = document.getElementById("email").value;
      var userPass = document.getElementById("password").value;
      console.log(userEmail);
      firebase.auth().signInWithEmailAndPassword(userEmail, userPass).catch(function(error) {
          // Handle Errors here.
          var errorCode = error.code;
          var errorMessage = error.message;
  
          window.alert("Error:" + error.message);
          // ...
        });
  }
  firebase.auth().onAuthStateChanged(function(user) {
  
    if (user) {
      // User is signed in.

      
      

      var user = firebase.auth().currentUser;
      if(user != null){
          var email_id = user.uid;
         alert(email_id);
         window.location.href = "a-index.html";
      }



    } else {
      // No user is signed in.
   console.log('hey eroor');
      
    }
  });
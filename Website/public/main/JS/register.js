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

  function signup(){
    var email=document.getElementById("useremail").value;
    var password=document.getElementById("userpassword").value;
    
    //Create User with Email and Password
    firebase.auth().createUserWithEmailAndPassword(email, password).catch(function(error) {
        window.location.href="userdetails.html";
        // Handle Errors here.
      var errorCode = error.code;
      var errorMessage = error.message;
      console.log(errorCode);
      console.log(errorMessage);
    });
  }
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.0/firebase-messaging.js');

firebase.initializeApp({
    apiKey: "AIzaSyDAlAS0Fz5KgAtEanPDIbN_aOPCZ1uqYws",
    authDomain: "ecommerce-36d06.firebaseapp.com",
    projectId: "ecommerce-36d06",
    storageBucket: "ecommerce-36d06.appspot.com",
    messagingSenderId: "900853072435",
    appId: "1:900853072435:web:98747c16f20aa44e23d946",
    measurementId: "G-ZZYFPWJGCB"
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message ', payload);
  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
    icon: '/firebase-logo.png'
  };

  self.registration.showNotification(notificationTitle, notificationOptions);
});

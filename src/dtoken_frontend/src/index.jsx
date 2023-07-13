import React from 'react';
import { createRoot } from 'react-dom/client';
import App from "./components/App";
import { AuthClient } from '@dfinity/auth-client';


const init = async () => { 
  const root = createRoot(document.getElementById("root"));
  const authClient = await AuthClient.create();

  if(authClient.isAuthenticated()){
    console.log("logged in");
    root.render(<App />);
    
  } else {
    await authClient.login({
      identityProvider: "https://identity.ic0.app/#authorize",
      onSuccess: () => {
        root.render(<App />);
      }
    })
  }
}

init();



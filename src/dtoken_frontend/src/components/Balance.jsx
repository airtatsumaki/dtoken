import React, { useState } from "react";
import { dtoken_backend } from "../../../declarations/dtoken_backend";
import { Principal } from "@dfinity/principal";

function Balance() {
  
  const [inputPrincipal, setInputPrincipal] = useState("");
  const [balance, setBalance] = useState("");
  const [symbol, setSymbol] = useState("");
  const [isHidden, setIsHidden] = useState(true);

  async function handleClick() {
    try{
      const prin = Principal.fromText(inputPrincipal);
      const newBalance = await dtoken_backend.balanceOf(prin);
      setBalance(newBalance.toLocaleString());
      const newSymbol = await dtoken_backend.getSymbol();
      setSymbol(newSymbol);
      setIsHidden(false);
    } catch(err) {
      console.log(err);
      setBalance(0);
      setIsHidden(true);
    }
  }

  return (
    <div className="window white">
      <label>Check account token balance:</label>
      <p>
        <input
          id="balance-principal-id"
          type="text"
          placeholder="Enter a Principal ID"
          value={inputPrincipal}
          onChange={(e) => setInputPrincipal(e.target.value)}
        />
      </p>
      <p className="trade-buttons">
        <button
          id="btn-request-balance"
          onClick={handleClick}
        >
          Check Balance
        </button>
      </p>
      <p hidden={isHidden}>This account has a balance of {balance} {symbol}.</p>
    </div>
  );
}

export default Balance;

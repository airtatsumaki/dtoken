import React, { useState } from "react";
import { dtoken_backend } from "../../../declarations/dtoken_backend";

function Faucet() {

  const [buttonText, setButtonText] = useState("Gimme gimme");
  const [btnDisabled, setBtnDisabled] = useState(false);

  async function handleClick(event) {
    setBtnDisabled(true);
    const response = await dtoken_backend.payout();
    setButtonText(response);
  }

  return (
    <div className="blue window">
      <h2>
        <span role="img" aria-label="tap emoji">
          🚰
        </span>
        Faucet
      </h2>
      <label>Get your free DAngela tokens here! Claim 10,000 DANG coins to your account.</label>
      <p className="trade-buttons">
        <button id="btn-payout" onClick={handleClick} disabled={btnDisabled}>
          {buttonText}
        </button>
      </p>
    </div>
  );
}

export default Faucet;

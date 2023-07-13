import React, { useState } from "react";
import { dtoken_backend } from "../../../declarations/dtoken_backend";
import { Principal } from "@dfinity/principal";

function Transfer() {

  const [transferObj, setTransferObj] = useState({to: "", amount: 0});
  const [buttonText, setButtonText] = useState("Transfer");
  const [isDisabled, setIsDisabled] = useState(false);
  
  async function handleClick() {
    setIsDisabled(true);
    console.log(transferObj);
    const prin = Principal.fromText(transferObj.to);
    console.log(prin);
    const response = await dtoken_backend.transfer(prin, parseFloat(transferObj.amount));
    setButtonText(response);
    setIsDisabled(false);
  }

  return (
    <div className="window white">
      <div className="transfer">
        <fieldset>
          <legend>To Account:</legend>
          <ul>
            <li>
              <input
                type="text"
                id="transfer-to-id"
                value={transferObj.to}
                onChange={(event) => {
                  const newTo = event.target.value;
                  setTransferObj((prev) => {
                    return {...prev, to: newTo}
                  });
                }}
              />
            </li>
          </ul>
        </fieldset>
        <fieldset>
          <legend>Amount:</legend>
          <ul>
            <li>
              <input
                type="number"
                id="amount"
                value={transferObj.amount}
                onChange={(event) => {
                  const newAmount = event.target.value;
                  setTransferObj((prev) => {
                    return {...prev, amount: newAmount}
                  });
                }}
              />
            </li>
          </ul>
        </fieldset>
        <p className="trade-buttons">
          <button id="btn-transfer" onClick={handleClick} disabled={isDisabled}>
            {buttonText}
          </button>
        </p>
      </div>
    </div>
  );
}

export default Transfer;

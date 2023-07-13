import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";

actor Token {
  var owner : Principal = Principal.fromText("j3c36-jizgl-sjgm4-hlylk-zxobn-dgg46-yf42i-jkdaz-2cjdn-xxe2d-rqe");
  var totalSupply : Nat = 1000000000;
  var symbol : Text = "DANG";

  var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);

  balances.put(owner, totalSupply);

  public query func balanceOf(who: Principal): async Nat{
    let balance : Nat = switch (balances.get(who)){
      case null 0;
      case (?result) result;
    };
    return balance;
  };

  public query func getSymbol(): async Text{
    return symbol;
  };

  public shared(msg) func payout(): async Text{
    Debug.print(debug_show(msg.caller));
    if(balances.get(msg.caller) == null){
      let amount = 10000;
      balances.put(msg.caller, amount);
      return "Success";
    } else {
      return "You can't claim any more tokens";
    };
  };

  public shared(msg) func transfer(to: Principal, amount: Nat): async Text{
    let fromAmount = await balanceOf(msg.caller);
    if(fromAmount > amount){
      let newFromAmount : Nat = fromAmount - amount;
      balances.put(msg.caller, newFromAmount);
      let toAmount = await balanceOf(to);
      let newToAmount : Nat = toAmount + amount;
      balances.put(to, newToAmount);
      return "Success";
    } else {
      return "Insufficient funds";
    };
  };
};
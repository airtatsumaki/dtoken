import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";
import Array "mo:base/Array";

actor Token {

  var owner : Principal = Principal.fromText("j3c36-jizgl-sjgm4-hlylk-zxobn-dgg46-yf42i-jkdaz-2cjdn-xxe2d-rqe");
  var totalSupply : Nat = 1000000000;
  var symbol : Text = "DANG";

  private stable var balancesArr: [(Principal, Nat)] = [];

  // cannot make balances a 'stable' variable. so have to move the data into an array and then moved back.
  // this is done via preupgrade/ postupgrade methods
  private var balances = HashMap.HashMap<Principal, Nat>(1, Principal.equal, Principal.hash);
  if(balances.size() < 1){
    balances.put(owner, totalSupply);
  };


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
      let response = await transfer(msg.caller, amount);
      balances.put(msg.caller, amount);
      return response;
    } else {
      return "You can't claim any more tokens";
    };
  };

  public shared(msg) func transfer(to: Principal, amount: Nat): async Text{
    Debug.print(debug_show(msg.caller));
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

  system func preupgrade(){
    balancesArr := Iter.toArray(balances.entries());
  };

  system func postupgrade(){
    balances := HashMap.fromIter<Principal, Nat>(balancesArr.vals(), 1, Principal.equal, Principal.hash);
    if(balances.size() < 1){
      balances.put(owner, totalSupply);
    };
  };

};
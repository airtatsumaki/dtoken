import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Nat "mo:base/Nat";

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
};
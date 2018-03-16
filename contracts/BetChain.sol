pragma solidity ^0.4.18;

import "./BetOrder.sol";
import "./DispatchPrize.sol";

contract BetChain is DispatchPrize,BetOrder{
    function getNowTime() public constant returns(uint256){
       return now;
    }
    function BetChain() {
        owner = msg.sender;
    }

    function transferBack(address target, uint256 coins) {
        require(msg.sender == owner);
        target.transfer(coins);
    }

    function () payable {
    }


}

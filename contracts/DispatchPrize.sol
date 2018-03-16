pragma solidity ^0.4.18;

import "./Order.sol";
import "./Salf.sol";

contract DispatchPrize is Order,SalfOperate{

    //奖金初始倍数设置
    uint16 internal randomOrder5 = 1;   //任5
    uint16 internal randomOrder4 = 128;   //任4
    uint16 internal randomOrder3 = 10;   // 任3

    modifier randomStrLegal(string randomStr) {
        require(bytes(randomStr).length == 66);
        _;
    }
    modifier Owner() {
        require(owner == msg.sender);
        _;
    }

    event winNumberLog(string _issue, string randomStr);

    function search(string _issue)constant public returns (uint256) {
        return orders[_issue].length;
    }

    function searchOrder(string _issue) constant public returns(uint){
        return orders[_issue].length;
    }

    function searchBalance()public constant returns(uint256){
        return this.balance;
    }

    function setWinNumbers(string _issue, string randomStr) Owner{
        bytes memory winNumbers = generateWinNumbers(randomStr, 5, 11);
        for (uint16 i=0; i<winNumbers.length; i++){
            winNumbersPerIssue[_issue].push(uint8(winNumbers[i]));
        }
        settleOrder(_issue);
        winNumberLog(_issue, randomStr);
    }

    function getWinNumbers(string _issue) public constant returns(uint8[]){
        return winNumbersPerIssue[_issue];
    }

    function settleOrder(string _issue) {
        //require(prizeNum.length==5);
        uint8[] prizeNum = winNumbersPerIssue[_issue];
        for(uint256 i=0; i<orders[_issue].length; i++){
            uint8 winNumberCount = checkArray(prizeNum, orders[_issue][i].betnums);
            if (winNumberCount == 5){
              // 更新为中奖状态，计算奖金
              orders[_issue][i].orderstatus = uint8(orderstatus.settle);
              orders[_issue][i].prizes = calculatePrize(orders[_issue][i].coins, winNumberCount);
            }
            else{
              orders[_issue][i].orderstatus = uint8(orderstatus.settle);
            }
        }
    }

    // 奖金计算
    function calculatePrize(uint256 betcoins, uint8 winNumberCount) returns(uint){
         return safeMultiply(betcoins, randomOrder5);
    }

    // 派奖
    function settlePrize(string _issue) public {
        require(issueStates[_issue] == uint8(issueState.init));
        for(uint256 i=0; i<orders[_issue].length; i++){
            if (orders[_issue][i].orderstatus == uint8(orderstatus.settle) && orders[_issue][i].prizes > 0){
                orders[_issue][i].orderstatus = uint8(orderstatus.prize);
                orders[_issue][i].sender.transfer(orders[_issue][i].prizes);
            }
        }
        issueStates[_issue] = uint8(issueState.settle);
    }



}

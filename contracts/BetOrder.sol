pragma solidity ^0.4.18;
import "./Order.sol";

contract BetOrder is Order{
    /* // 订单状态
    enum orderstatus {create, success, fail, settle, prize}
    // 每期开奖状态
    enum issueState {init, settle}
    // 投注开关
    enum switchState {on, off}

    // 单个订单结构
    struct order {
        uint8 orderstatus;  //订单状态
        uint8[] betnums;   //投注号码
        uint8 times;   //投注倍数
        uint256 coins;  //投注代币金额
        uint256 prizes; //中奖金额
        address sender; // 投注地址
    } */

    address internal owner;

    uint8 private totalnumber = 5;
    uint256 private betcoins = 1*10**14;
    uint8 private Switch = uint8(switchState.on);

    /* // 订单格式(期号=>订单列表)
    mapping (uint256 => order[]) orders;
    mapping(uint256 => uint8) issueStates; */

    event placeorder(address msg, uint8 [] betnums, uint256 value);

    modifier isLength(uint8[] array){
        require(array.length == totalnumber);
        _;
    }
    modifier limitBet(){
        require(msg.value > betcoins);
        _;
    }
    modifier limitIssue(string _issue){
        require(issueStates[_issue] != uint8(issueState.settle));
        _;
    }
    modifier betSwitch(){
        require(Switch == uint8(switchState.on));
        _;
    }

    modifier onlyOwner() {
        assert(msg.sender == owner);
        _;
    }

    // 订单下注
    function placeOrder(string _issue, uint8[] betnums)
      public
      payable
      limitBet
      betSwitch
      limitIssue(_issue)
      isLength(betnums)
    {
        placeorder(msg.sender, betnums, msg.value);
        order memory odr;
        odr.orderstatus = uint8(orderstatus.create);
        odr.betnums = betnums;
        odr.coins = msg.value;
        odr.sender = msg.sender;
        orders[_issue].push(odr);
    }


}

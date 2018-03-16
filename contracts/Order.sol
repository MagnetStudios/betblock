pragma solidity ^0.4.18;

contract Order{
    // 订单状态
    enum orderstatus {create, success, fail, settle, prize}
    // 每期开奖状态
    enum issueState {init, settle}
    // 投注开关
    enum switchState {on, off}

    mapping (string => uint8[]) winNumbersPerIssue;
    address internal owner;
    // 单个订单结构
    struct order {
        uint8 orderstatus;  //订单状态
        uint8[] betnums;   //投注号码
        uint8 times;   //投注倍数
        uint256 coins;  //投注代币金额
        uint256 prizes; //中奖金额
        address sender; // 投注地址
    }

    /* uint8 private totalnumber = 5;
    uint256 private betcoins = 1*10**14;
    uint8 private Switch = uint8(switchState.on); */

    // 订单格式(期号=>订单列表)
    mapping (string => order[]) internal orders;
    mapping (string => uint8) internal issueStates;
}

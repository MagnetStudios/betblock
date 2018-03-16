pragma solidity ^0.4.18;

contract SalfOperate {

    // 返回相同号码的个数
    function checkArray(uint8[] a, uint8[] b) internal returns (uint8) {
        require(a.length==b.length);
        //uint256[5] memory c=a;
        uint8 equalNumberCount;
        for(uint8 i=0; i<a.length; i++){
            for(uint8 j=0; j < b.length; j++){
                if (a[i]==b[j]){
                      equalNumberCount++;
                }
            }
        }
        return equalNumberCount;
    }

    // 检测两个数组是否相等
    function checkEqual(uint8[] a, uint8[] b) internal returns(bool){
        require(a.length==b.length);
        for(uint8 i=0; i<a.length; i++){
            if (a[i] != b[i]){
                return false;
            }
        }
        return true;
    }

    function safeMultiply(uint a, uint b) internal returns (uint) {
        uint c = a * b;
        assert(a == 0 || (c / a) == b);
        return c;
    }

    function generateWinNumbers(string randomStr, uint numberCount, uint numberCountMax) constant public returns(bytes){
        //bytes memory random = block.blockhash(block.number-1);
        bytes memory random = bytes(randomStr);
        bytes memory allNumbers = new bytes(numberCountMax);
        bytes memory winNumbers = new bytes(numberCount);
        for (uint i=0; i< numberCountMax; i++){
            allNumbers[i]=byte(i+1);
        }

        for(i=0;i<numberCount;i++){
            uint n = numberCountMax -i;
            uint r = uint(random[random.length-1-i]) % n;
            winNumbers[i] = allNumbers[r];
            allNumbers[r] = allNumbers[n-1];
        }
        return winNumbers;
    }

}

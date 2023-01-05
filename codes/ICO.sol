// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract ICO is ERC20,Ownable{
    constructor() ERC20("IneuronCoin","INC"){
        _mint(msg.sender, 1000000*(10**uint256(decimals()))); /// 1 million coins
    }
// *** all values in wei(input  & output) convert into normal by dividing with 10^18.

    function mint(address account,uint256 amount) public onlyOwner returns(bool){
        require(account!=address(this) && amount!=uint256(0),"ERC20: mint function invalid input");
        _mint(account, amount); // amount*10^18
        return true;
    }

    function burn(address account,uint256 amount) public onlyOwner returns(bool){
         require(account!=address(this) && amount!=uint256(0),"ERC20: burn function invalid input");
        _burn(account, amount); /// amount*10^18
        return true;
    }

      function buy() public payable returns(bool){
        require(msg.sender.balance>=msg.value && msg.value !=0 ether,"ICO : invalid buy input");
        uint amount=msg.value*1000;
        _transfer(owner(),_msgSender(),amount);
        return true;
    }



    function withdraw(uint256 amount) public  onlyOwner returns(bool){
      require( amount<= address(this).balance,"ERC20: withdraw function invalid input");  
       payable(_msgSender()).transfer(amount); 
        return true ;
    }
}
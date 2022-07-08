// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract Guess{
    address owner;
    string private word;
    address[] public regeisterd;
    mapping(address=>uint)public code;
    mapping(address=>bool) public checkk;
    mapping(address=>bool) winner;
    uint i =0;
    uint count = 0;
    
    function hostthegame(address _owner)public payable{
        require(msg.value>1000 wei);
        owner = _owner;
    }
    function setaword(string memory _word)public{
        require(msg.sender==owner,"You are not the owner");
        word = _word;
    }
    function regeister() public  payable{
        require(msg.value == 500 && checkk[msg.sender]==false);
        regeisterd.push(msg.sender);
        code[msg.sender] = i;
        checkk[msg.sender]=true;
        i++;
    }
    function Getyourcode() public view returns(uint){
        require(checkk[msg.sender] == true);
        return code[msg.sender];
    }
    function guesstheword(uint Enteryourcode,string memory Guessword) public view returns(string memory){
        require(code[msg.sender]==Enteryourcode && checkk[msg.sender]==true,"Invalid code or you are not the owner of the code");
        if(keccak256(abi.encodePacked(Guessword)) == keccak256(abi.encodePacked(word))){
            winner[msg.sender]==true;
            return "You are the winner hurhee";

        }else{
            return "You are not the winner";
        }
  
    }
    function claimprice() public{
        require(winner[msg.sender] == true,"You are not the winner");
        address payable tran = payable(msg.sender);
        tran.transfer(800);

    }
    
    
   
}

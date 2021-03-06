pragma solidity ^0.4.16;

/*
	@title GeeToken
*/

import "./MigratableToken.sol";

/*
	Contract defines specific token
*/
contract GEEToken is MigratableToken {

    //Name of the token
    string public constant name = "Geens Platform Token";
    //Symbol of the token
    string public constant symbol = "GEE";
    //Number of decimals of Gee
    uint8 public constant decimals = 8;

    //Team allocation
    //Team wallet that will be unlocked after 0.5 year after ICO
    address public constant team1 = 0x3eC28367f42635098FA01dd33b9dd126247Fb4B1;
    //Team wallet that will be unlocked after 1 year after ICO
    address public constant team2 = 0xE2832C2Ff2754923B3172474F149630823ecb8D6;
    //0.5 year after ICO
    uint256 public constant blockTeam1 = 1835640;
    //1 year after ICO
    uint256 public constant blockTeam2 = 1835650;
    //1st team wallet balance
    uint256 public team1Balance;
    //2nd team wallet balance
    uint256 public team2Balance;

    //3.6%
    uint256 private constant team1Percent = 36;
    //6%
    uint256 private constant team2Percent = 60;
    //88%
    uint256 private constant icoAndCommunityPercent = 880;
    //100%
    uint256 private constant percent100 = 1000;

    function GEEToken() {
        uint256 icoAndCommunityTokens = totalSupply * icoAndCommunityPercent / percent100;
    	//88% of totalSupply
        balances[msg.sender] = icoAndCommunityTokens;
        //3.6% of totalSupply
        team1Balance = totalSupply * team1Percent / percent100;
        //6% of totalSupply
        team2Balance = totalSupply * team2Percent / percent100;

        Transfer (this, msg.sender, icoAndCommunityTokens);
    }

    //Check if team wallet is unlocked
    function unlockTeamTokens(address _address) external onlyOwner  {
        if (_address == team1) {
            require(blockTeam1 <= block.number);
            require (team1Balance > 0);
            balances[team1] = team1Balance;
            team1Balance = 0;
            Transfer (this, team1, team1Balance);
        } else if (_address == team2) {
            require(blockTeam2 <= block.number);
            require (team2Balance > 0);
            balances[team2] = team2Balance;
            team2Balance = 0;
            Transfer (this, team2, team2Balance);
        }
    }

}

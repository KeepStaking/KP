///@dev KP are points accrued to kETH stakers. This incentivizes people to stake their ETH.
///@dev KP are essentially soulbound ERC20 streaming tokens

//SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/access/Ownable.sol";
import {GIGADRIP20} from "DRIP20/GIGADRIP20.sol";

contract KP is Ownable, GIGADRIP20 {
    error NotOwnerOrAdmin();
    error NonTransferrable();

    // should be the kETH contract
    address public admin;

    constructor(
        string memory _name, // keep points
        string memory _symbol, // KP
        uint8 _decimals, // 18
        uint256 _emissionRatePerBlock, // up to you, maybe 1 point per day per kETH locked?
        address _admin // should be kETH contract
    ) GIGADRIP20(_name, _symbol, _decimals, _emissionRatePerBlock) {
        admin = _admin;
    }

    /*==============================================================
    ==                    Dripping Functions                      ==
    ==============================================================*/

    /**
     * @dev should be called from keth contract to start accruing KP for holder.
     * @param multiplier number of KP staked.
     */
    function startDripping(address addr, uint128 multiplier) external {
        if (msg.sender != admin && msg.sender != owner())
            revert NotOwnerOrAdmin();

        _startDripping(addr, multiplier);
    }

    /**
     * @dev should be called from keth contract to start accruing KP for holder.
     * @param multiplier number of KP unstaked.
     */
    function stopDripping(address addr, uint128 multiplier) external {
        if (msg.sender != admin && msg.sender != owner())
            revert NotOwnerOrAdmin();

        _stopDripping(addr, multiplier);
    }

    /*==============================================================
    ==                    Only Owner Functions                    ==
    ==============================================================*/

    /**
     * @dev mint tokens to desired address.
     * may be used for prize pools, DEX liquidity, etc.
     * will remove ownership when not needed so extra tokens cannot be minted.
     */
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    function setAdmin(address _admin) external onlyOwner {
        admin = _admin;
    }

    /*==============================================================
    ==                         Override                           ==
    ==============================================================*/

    function transfer(address to, uint256 amount)
        public
        override
        returns (bool)
    {
        revert NonTransferrable();
    }

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public override returns (bool) {
        revert NonTransferrable();
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract SupplyChainPayment {

    address public buyer;
    address public seller;
    uint public amount;
    bool public goodsReceived;
    bool public paymentReleased;

    constructor(address _seller) payable {
        buyer = msg.sender;
        seller = _seller;
        amount = msg.value;
        goodsReceived = false;
        paymentReleased = false;
    }

    function confirmDelivery() public {
        require(msg.sender == buyer, "Only buyer can confirm delivery");
        goodsReceived = true;
    }

    function releasePayment() public {
        require(goodsReceived == true, "Goods not confirmed");
        require(paymentReleased == false, "Payment already released");
        paymentReleased = true;
        payable(seller).transfer(amount);
    }
}

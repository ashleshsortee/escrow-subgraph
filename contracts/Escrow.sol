pragma solidity 0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Escrow {
  IERC20 private _usdtInstance;

  struct Deal {
    uint256 productId;
    address seller;
    address buyer;
    uint256 amount;
    bool isCompleted;
    bool isAck;
  }

  Deal[] private deals;
  mapping(uint256 => Deal) productIdToDeal;

  event Purchase(uint256, uint256, address, address);
  event Ack(uint256, address);
  event Claim(uint256, uint256);

  constructor(address usdtAddress) {
    _usdtInstance = IERC20(usdtAddress);
  }

  function purchase(
    uint256 productId,
    uint256 amount,
    address seller
  ) public {
    Deal memory newDeal = Deal(
      productId,
      seller,
      msg.sender,
      amount,
      false,
      false
    );
    deals.push(newDeal);
    productIdToDeal[productId] = newDeal;

    _usdtInstance.transferFrom(msg.sender, address(this), amount);

    emit Purchase(productId, amount, msg.sender, seller);
  }

  function acknowledgeProduct(uint256 productId) public {
    Deal storage deal = productIdToDeal[productId];
    require(msg.sender == deal.buyer, "Caller is not the buyer!");
    deal.isAck = true;

    emit Ack(productId, msg.sender);
  }

  function claimPayment(uint256 productId) public {
    Deal storage deal = productIdToDeal[productId];
    require(msg.sender == deal.seller, "Caller is not the seller!");
    deal.isCompleted = true;

    _usdtInstance.transfer(deal.seller, deal.amount);

    emit Claim(productId, deal.amount);
  }

  function viewDeal(uint256 productId) public view returns (Deal memory) {
    return productIdToDeal[productId];
  }
}

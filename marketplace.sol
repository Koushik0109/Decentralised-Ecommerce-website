pragma solidity ^0.8.0;

contract Marketplace {
    address payable public owner;
    mapping(address => bool) public sellers;
    mapping(uint => Product) public products;
    mapping(address => mapping(uint => bool)) public purchased;
    mapping(address => mapping(uint => bool)) public disputes;
    mapping(address => mapping(uint => bytes32)) public reviews;
    mapping(address => mapping(address => uint)) public reputation;

    struct Product {
        address payable seller;
        uint price;
        string name;
        string description;
    }

    event ProductListed(uint productId);
    event ProductPurchased(uint productId);
    event DisputeRaised(uint productId);
    event DisputeResolved(uint productId);

    constructor() public {
        owner = msg.sender;
    }

    function addSeller(address seller) public {
        require(msg.sender == owner);
        sellers[seller] = true;
    }

    function removeSeller(address seller) public {
        require(msg.sender == owner);
        sellers[seller] = false;
    }

    function listProduct(address payable seller, uint price, string memory name, string memory description) public {
require(sellers[seller]);
uint productId = products.length++;
products[productId] = Product(seller, price, name, description);
emit ProductListed(productId);
}
function purchaseProduct(uint productId, address buyer) public payable {
    require(products[productId].price <= msg.value);
    require(!purchased[buyer][productId]);
    products[productId].seller.transfer(products[productId].price);
    purchased[buyer][productId] = true;
    emit ProductPurchased(productId);
}

function raiseDispute(uint productId, address buyer) public {
    require(purchased[buyer][productId]);
    disputes[buyer][productId] = true;
    emit DisputeRaised(productId);
}

function resolveDispute(uint productId, address buyer, bool refund) public {
    require(msg.sender == owner);
    require(disputes[buyer][productId]);
    if (refund) {
        buyer.transfer(products[productId].price);
    }
    disputes[buyer][productId] = false;
    emit DisputeResolved(productId);
}

function leaveReview(uint productId, address buyer, bytes32 review) public {
    require(purchased[buyer][productId]);
    reviews[buyer][productId] = review;
}

function rateSeller(address seller, address rater, uint rating) public {
    reputation[seller][rater] = rating;
}
function getProduct(uint productId) public view returns (address payable, uint, string memory, string memory) {
return (products[productId].seller, products[productId].price, products[productId].name, products[productId].description);
}
function getSellerReputation(address seller) public view returns (uint) {
    uint reputationSum = 0;
    uint numRatings = 0;
    for (address rater in reputation[seller]) {
        reputationSum += reputation[seller][rater];
        numRatings++;
    }
    return reputationSum / numRatings;
}
}
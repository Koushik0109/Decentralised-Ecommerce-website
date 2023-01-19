# Decentralised-Ecommerce-website

This smart contract is for a decentralized marketplace where users can buy and sell goods and services using smart contracts and cryptocurrency.

The contract allows for the listing, purchasing, and management of products. It also includes features such as a dispute resolution system, a reputation system, and reviews. It allows for the addition and removal of sellers by the owner of the smart contract.

The Marketplace smart contract has the following main functions:

addSeller(address seller): This function allows the owner of the contract to add a new seller to the marketplace.

removeSeller(address seller): This function allows the owner of the contract to remove an existing seller from the marketplace.

listProduct(address payable seller, uint price, string memory name, string memory description): This function allows a seller to list a new product for sale on the marketplace.

purchaseProduct(uint productId, address buyer): This function allows a buyer to purchase a product from the marketplace.

raiseDispute(uint productId, address buyer): This function allows a buyer to raise a dispute for a product they have purchased.

resolveDispute(uint productId, address buyer, bool refund): This function allows the owner of the contract to resolve a dispute and refund the buyer if necessary.

leaveReview(uint productId, address buyer, bytes32 review): This function allows a buyer to leave a review for a product they have purchased.

rateSeller(address seller, address rater, uint rating): This function allows a buyer to rate a seller they have purchased from.

getProduct(uint productId): This function allows anyone to retrieve the details of a product by its ID.

getSellerReputation(address seller): This function allows anyone to retrieve the average reputation of a seller by averaging all the ratings received by the seller. If there are no ratings, the function returns 0.

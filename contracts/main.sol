// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DigitalWarranty {
    // Address of the manufacturer (contract owner)
    address public manufacturer;

    // Struct to represent each product warranty
    struct Warranty {
        address buyer;
        string productName;
        uint256 issueDate;
        uint256 expiryDate;
        bool isClaimed;
    }

    // Mapping of unique warranty IDs to their data
    mapping(bytes32 => Warranty) public warranties;

    // Event logs (to be emitted when actions occur)
    event WarrantyRegistered(address indexed buyer, string productName, uint256 expiryDate);
    event WarrantyVerified(address indexed buyer, string productName, bool isValid);

    // Constructor assigns contract deployer as manufacturer
    constructor() {
        manufacturer = msg.sender;
    }

    // Restrict function access to manufacturer only
    modifier onlyManufacturer() {
        require(msg.sender == manufacturer, "Only manufacturer can perform this action");
        _;
    }

    // Placeholder function for registering warranty (logic to be added later)
    function registerWarranty(
        address _buyer,
        string memory _productName,
        uint256 _validityDays
    ) public onlyManufacturer {
        require(_buyer != address(0), "Invalid buyer address");

        // Generate unique warranty ID (for demonstration only)
        bytes32 warrantyId = keccak256(abi.encodePacked(_buyer, _productName, block.timestamp));

        warranties[warrantyId] = Warranty({
            buyer: _buyer,
            productName: _productName,
            issueDate: block.timestamp,
            expiryDate: block.timestamp + (_validityDays * 1 days),
            isClaimed: false
        });

        emit WarrantyRegistered(_buyer, _productName, block.timestamp + (_validityDays * 1 days));
    }

    // Placeholder verification function
    function verifyWarranty(bytes32 _warrantyId) public view returns (bool) {
        Warranty memory w = warranties[_warrantyId];
        bool valid = (w.buyer != address(0) && block.timestamp <= w.expiryDate && !w.isClaimed);
        return valid;
    }
}

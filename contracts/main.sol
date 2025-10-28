// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Digital Warranty DApp
/// @notice This smart contract allows manufacturers to issue, verify, and manage product warranties on-chain.

contract DigitalWarranty {
    // Address of the manufacturer (deployer)
    address public manufacturer;

    /// @dev Warranty structure representing product warranty details
    struct Warranty {
        address buyer;
        string productName;
        uint256 issueDate;
        uint256 expiryDate;
        bool isClaimed;
    }

    // Mapping of unique warranty IDs to Warranty details
    mapping(bytes32 => Warranty) public warranties;

    // Events for major state changes
    event WarrantyRegistered(bytes32 indexed warrantyId, address indexed buyer, string productName, uint256 expiryDate);
    event WarrantyVerified(bytes32 indexed warrantyId, bool isValid);
    event WarrantyClaimed(bytes32 indexed warrantyId, address indexed buyer);

    // Modifiers
    modifier onlyManufacturer() {
        require(msg.sender == manufacturer, "Only manufacturer can perform this action");
        _;
    }

    modifier onlyBuyer(bytes32 _warrantyId) {
        require(warranties[_warrantyId].buyer == msg.sender, "Only registered buyer can claim this warranty");
        _;
    }

    /// @notice Constructor sets deployer as manufacturer
    constructor() {
        manufacturer = msg.sender;
    }

    /// @notice Register a new warranty for a product
    /// @param _buyer The address of the buyer
    /// @param _productName The name of the product
    /// @param _validityPeriod Duration in seconds for which warranty is valid
    function registerWarranty(address _buyer, string memory _productName, uint256 _validityPeriod)
        external
        onlyManufacturer
    {
        require(_buyer != address(0), "Invalid buyer address");
        require(_validityPeriod > 0, "Invalid validity period");

        bytes32 warrantyId = keccak256(abi.encodePacked(_buyer, _productName, block.timestamp));
        warranties[warrantyId] = Warranty({
            buyer: _buyer,
            productName: _productName,
            issueDate: block.timestamp,
            expiryDate: block.timestamp + _validityPeriod,
            isClaimed: false
        });

        emit WarrantyRegistered(warrantyId, _buyer, _productName, block.timestamp + _validityPeriod);
    }

    /// @notice Verify whether a warranty is still valid
    /// @param _warrantyId The unique identifier of the warranty
    /// @return isValid Whether the warranty is still valid or expired
    function verifyWarranty(bytes32 _warrantyId) external returns (bool isValid) {
        Warranty memory w = warranties[_warrantyId];
        require(w.buyer != address(0), "Warranty not found");

        isValid = (block.timestamp <= w.expiryDate && !w.isClaimed);
        emit WarrantyVerified(_warrantyId, isValid);
        return isValid;
    }

    /// @notice Claim an active warranty by the buyer
    /// @param _warrantyId The unique identifier of the warranty
    function claimWarranty(bytes32 _warrantyId) external onlyBuyer(_warrantyId) {
        Warranty storage w = warranties[_warrantyId];
        require(block.timestamp <= w.expiryDate, "Warranty expired");
        require(!w.isClaimed, "Warranty already claimed");

        w.isClaimed = true;
        emit WarrantyClaimed(_warrantyId, msg.sender);
    }

    /// @notice Get details of a specific warranty
    /// @param _warrantyId The unique identifier of the warranty
    /// @return buyer, productName, issueDate, expiryDate, isClaimed
    function getWarrantyDetails(bytes32 _warrantyId)
        external
        view
        returns (address, string memory, uint256, uint256, bool)
    {
        Warranty memory w = warranties[_warrantyId];
        return (w.buyer, w.productName, w.issueDate, w.expiryDate, w.isClaimed);
    }
}

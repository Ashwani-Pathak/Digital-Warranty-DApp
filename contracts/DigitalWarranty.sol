// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract DigitalWarranty {
    address public manufacturer;

    struct Warranty {
        string productName;
        address currentOwner;
        uint256 purchaseDate;
        uint256 warrantyPeriod; // in seconds
        bool isValid;
    }

    mapping(string => Warranty) public warranties;

    event WarrantyIssued(string warrantyID, string productName, address owner, uint256 purchaseDate, uint256 warrantyPeriod);
    event OwnershipTransferred(string warrantyID, address oldOwner, address newOwner);
    event WarrantyRevoked(string warrantyID);
    event WarrantyExtended(string warrantyID, uint256 oldPeriod, uint256 newPeriod);

    modifier onlyManufacturer() {
        require(msg.sender == manufacturer, "Not authorized");
        _;
    }

    constructor() {
        manufacturer = msg.sender;
    }

    // Issue new warranty
    function issueWarranty(
        string memory _warrantyID,
        string memory _productName,
        address _buyer,
        uint256 _warrantyPeriod
    ) public onlyManufacturer {
        require(warranties[_warrantyID].purchaseDate == 0, "Warranty already exists");
        warranties[_warrantyID] = Warranty(_productName, _buyer, block.timestamp, _warrantyPeriod, true);
        emit WarrantyIssued(_warrantyID, _productName, _buyer, block.timestamp, _warrantyPeriod);
    }

    // Transfer warranty ownership (resale or gift)
    function transferOwnership(string memory _warrantyID, address _newOwner) public {
        require(warranties[_warrantyID].currentOwner == msg.sender, "Not warranty owner");
        require(warranties[_warrantyID].isValid, "Warranty invalid");
        address oldOwner = warranties[_warrantyID].currentOwner;
        warranties[_warrantyID].currentOwner = _newOwner;
        emit OwnershipTransferred(_warrantyID, oldOwner, _newOwner);
    }

    // Extend warranty period by manufacturer
    function extendWarranty(string memory _warrantyID, uint256 _additionalTime) public onlyManufacturer {
        require(warranties[_warrantyID].purchaseDate != 0, "Warranty not found");
        uint256 oldPeriod = warranties[_warrantyID].warrantyPeriod;
        warranties[_warrantyID].warrantyPeriod += _additionalTime;
        emit WarrantyExtended(_warrantyID, oldPeriod, warranties[_warrantyID].warrantyPeriod);
    }

    // Check warranty validity
    function checkValidity(string memory _warrantyID) public view returns (bool) {
        Warranty memory w = warranties[_warrantyID];
        require(w.purchaseDate != 0, "Warranty not found");
        if (block.timestamp <= w.purchaseDate + w.warrantyPeriod && w.isValid) {
            return true;
        }
        return false;
    }

    // Get warranty details
    function verifyWarranty(string memory _warrantyID)
        public
        view
        returns (string memory, address, uint256, uint256, bool)
    {
        Warranty memory w = warranties[_warrantyID];
        require(w.purchaseDate != 0, "Warranty not found");
        return (w.productName, w.currentOwner, w.purchaseDate, w.warrantyPeriod, w.isValid);
    }

    // Revoke warranty
    function revokeWarranty(string memory _warrantyID) public onlyManufacturer {
        require(warranties[_warrantyID].isValid, "Already revoked");
        warranties[_warrantyID].isValid = false;
        emit WarrantyRevoked(_warrantyID);
    }
}

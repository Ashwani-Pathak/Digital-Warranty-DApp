// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract CertificateVerification {
    struct Certificate {
        string studentName;
        string courseName;
        string issuedBy;
        uint256 issueDate;
        bool isValid;
    }

    mapping(bytes32 => Certificate) public certificates;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not authorized");
        _;
    }

    function issueCertificate(
        string memory studentName,
        string memory courseName,
        string memory issuedBy,
        uint256 issueDate
    ) public onlyOwner {
        bytes32 certHash = keccak256(abi.encodePacked(studentName, courseName, issueDate));
        certificates[certHash] = Certificate(studentName, courseName, issuedBy, issueDate, true);
    }

    function verifyCertificate(
        string memory studentName,
        string memory courseName,
        uint256 issueDate
    ) public view returns (bool) {
        bytes32 certHash = keccak256(abi.encodePacked(studentName, courseName, issueDate));
        return certificates[certHash].isValid;
    }
}

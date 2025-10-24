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
}
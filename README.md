# 🧾 Digital Warranty DApp

A blockchain-based decentralized application (DApp) that enables manufacturers to issue and manage product warranties securely and transparently using smart contracts on the Ethereum network.

---

## 📘 Table of Contents
1. [Overview](#overview)
2. [Objective](#objective)
3. [Key Features](#key-features)
4. [Smart Contract Structure](#smart-contract-structure)
5. [Functions Overview](#functions-overview)
6. [Deployment Details](#deployment-details)
7. [Future Scope](#future-scope)
8. [Repository Structure](#repository-structure)
9. [Commit Summary](#commit-summary)

---

## 🧠 Overview

**Digital Warranty DApp** leverages blockchain technology to eliminate fraudulent warranty claims and simplify product warranty management.  
The system ensures transparency, immutability, and trust between manufacturers and consumers.

Each warranty is uniquely linked to a buyer’s address and stored on-chain, preventing tampering or duplication.  
Consumers can verify their warranty status anytime, while manufacturers can manage and track issued warranties efficiently.

---

## 🎯 Objective

To replace traditional paper-based and centralized warranty systems with a decentralized alternative that is:
- Transparent  
- Verifiable  
- Tamper-proof  
- Cost-efficient

---

## 🚀 Key Features

- **Manufacturer-Based Access Control:** Only the manufacturer (contract owner) can issue warranties.  
- **Unique Warranty ID Generation:** Each warranty is identified using a SHA3 (`keccak256`) hash.  
- **On-Chain Storage:** Warranty details are stored on Ethereum for traceability.  
- **Validity Verification:** Buyers can verify if their warranty is still active.  
- **Event Emission:** Logs warranty registration and verification for transparency.

---

## 🧩 Smart Contract Structure

**Contract Name:** `DigitalWarranty.sol`  
**Language:** Solidity `^0.8.20`  
**License:** MIT  

### State Variables
| Variable | Type | Description |
|-----------|------|-------------|
| `manufacturer` | `address` | Owner of the contract, allowed to issue warranties. |
| `warranties` | `mapping(bytes32 => Warranty)` | Stores all warranty records using unique IDs. |

### Struct Definition
```solidity
struct Warranty {
    address buyer;
    string productName;
    uint256 issueDate;
    uint256 expiryDate;
    bool isClaimed;
}
⚙️ Functions Overview
Function	Visibility	Description
constructor()	public	Sets contract deployer as manufacturer.
registerWarranty(address _buyer, string memory _productName, uint256 _validityDays)	public onlyManufacturer	Registers a new warranty.
verifyWarranty(bytes32 _warrantyId)	public view	Verifies if a warranty is valid and unclaimed.

🧾 Events
Event	Parameters	Description
WarrantyRegistered(address buyer, string productName, uint256 expiryDate)	Buyer, Product Name, Expiry	Emitted on new warranty registration.
WarrantyVerified(address buyer, string productName, bool isValid)	Buyer, Product Name, Status	Emitted when a warranty is checked.

📦 Deployment Details
Network: Ethereum (Testnet recommended: Sepolia or Core Testnet)

Compiler Version: ^0.8.20

Framework: Hardhat / Remix IDE

Contract Address: (To be added after deployment)

Transaction Screenshot: (Attach post-deployment proof)

🔮 Future Scope
Warranty Claim and Renewal functionality

NFT-based transferable warranties

QR/NFC integration for on-device verification

Multi-manufacturer support and analytics dashboard

Integration with supply chain systems

📁 Repository Structure
Copy code
Digital-Warranty-DApp/
│
├── Contracts/
│   └── DigitalWarranty.sol
│
└── README.md
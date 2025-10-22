🧾 Certificate Verification System (Solidity)
📌 Overview

The Certificate Verification System is a decentralized smart contract built on Ethereum that enables trusted organizations to issue and verify digital certificates on-chain. Each certificate is uniquely identified by a hash and permanently stored on the blockchain, ensuring authenticity and preventing forgery.

⚙️ Features

Issue Certificates: Only the authorized issuer can create and store new certificates.

Verify Certificates: Anyone can verify a certificate using its unique hash.

Revoke Certificates (optional): Issuers can revoke certificates if needed.

Tamper-Proof: All records are stored immutably on the blockchain.

Gas Efficient: Uses optimized mappings for minimal cost.

🧩 Smart Contract Structure
Component	Description
struct Certificate	Holds details like recipient, course name, and issuance date.
mapping(bytes32 => Certificate)	Maps each certificate hash to its record.
issueCertificate()	Function to issue and store a new certificate.
verifyCertificate()	Function to check if a certificate exists and is valid.
revokeCertificate() (optional)	Function to revoke a certificate.
🧠 Tech Stack

Language: Solidity

Frameworks/Tools: Hardhat / Remix / Foundry (any)

Network: Ethereum / Core / Polygon (testnet recommended)

License: MIT

🚀 Getting Started
1. Clone the Repository
git clone https://github.com/Ashwani-Pathak/VerifyCert.git
cd certificate-verification-system

2. Compile the Contract
npx hardhat compile

3. Deploy the Contract
npx hardhat run scripts/deploy.js --network <network-name>

4. Interact

You can interact using:

Hardhat console

Remix IDE (load the contract and deploy directly)

Web3.js or Ethers.js frontend (optional)

🧪 Example Usage
// Issuer issues certificate
issueCertificate("John Doe", "Blockchain Fundamentals", "hash123");

// Verify certificate
verifyCertificate("hash123"); // returns true or certificate details

🔒 Security Notes

Restrict certificate issuance to the contract owner or authorized address.

Always validate certificate hashes off-chain before submission.

📄 License

This project is licensed under the MIT License — feel free to modify and use it for educational or institutional purposes.
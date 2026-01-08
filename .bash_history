unzip acpn-monorepo.zip
cd acpn-monorepo
git init
git add .
git commit -m "Initial ACPN monorepo"
git branch -M main
git remote add origin https://github.com/<org-or-user>/acpn.git
git push -u origin main
pkg install git
unzip acpn-monorepo.zip
cd acpn-monorepo
git init
git add .
git commit -m "Initial ACPN monorepo"
git branch -M main
git remote add origin https://github.com/<org-or-user>/acpn.git
git push -u origin main
git config --global user.email "iam.thomas.lisk@gmail.com"
git init
git add .
git commit -m "Initial ACPN core specification"
git branch -M main
git remote add origin https://github.com/<you>/acpn-core.git
git push -u origin main
git init
git add .
git commit -m "Initial ACPN core specification"
git branch -M main
git remote add origin https://github.com/<you>/acpn-core.git
git push -u origin main
acpn-core/
├── RFC/
│   ├── RFC-0001.md
│   ├── RFC-0002-did.md
│   ├── RFC-0003-zk-quorum.md
│   └── RFC-0004-sealing.md
│
├── schemas/
│   ├── did.schema.json
│   ├── scd.schema.json
│   └── signature.schema.json
│
├── test-vectors/
│   ├── valid/
│   │   ├── did.json
│   │   ├── scd.json
│   │   └── zk-public.json
│   └── invalid/
│       ├── did-expired.json
│       └── scd-tampered.json
│
├── SECURITY.md
├── LICENSE
└── README.md
import init, { ACPNTrigger } from './pkg/acpn_trigger.js';
import { ethers } from 'ethers';
await init();
// WASM trigger
const trigger = new ACPNTrigger(
);
// Embed content
const metadata = trigger.embed_metadata("YourBase64EncodedContent");
console.log("Embedded Metadata:", metadata);
// Validate access
try {
} catch (e) {
}
// Revocation flow
const message = trigger.revocation_message(Date.now());
const hash = trigger.generate_hash(message);
// ethers signing
const wallet = new ethers.Wallet(
);
const signature = await wallet.signMessage(
);
console.log("Revocation hash:", hash);
console.log("Signature:", signature);
import init, { ACPNTrigger } from './pkg/acpn_trigger.js';
import { ethers } from 'ethers';
await init();
// WASM trigger
const trigger = new ACPNTrigger(
);
// Embed content
const metadata = trigger.embed_metadata("YourBase64EncodedContent");
console.log("Embedded Metadata:", metadata);
// Validate access
try {
} catch (e) {
}
// Revocation flow
const message = trigger.revocation_message(Date.now());
const hash = trigger.generate_hash(message);
// ethers signing
const wallet = new ethers.Wallet(
);
const signature = await wallet.signMessage(
);
console.log("Revocation hash:", hash);
console.log("Signature:", signature);
const wallet 
const wallet = new ethers.wallet
npm install
cd wasm && cargo build --target wasm32-unknown-unknown && wasm-pack build
npx hardhat compile
cd contracts
npm install
cd ..cd wasm
cargo install wasm-pack  # If not already installed
wasm-pack build --target web
cd ..pkg install rust
pkg install rust
cd wasm
cargo install wasm-pack  # If not already installed
wasm-pack build --target web
cd ..cargo install wasm-pack
cargo install wasm-pack
cd contracts
npx hardhat compile
cd ..contracts
cd contracts
cmake contracts
install cmake
pkg install cmake
cd wasm
cargo install wasm-pack  # If not already installed
wasm-pack build --target web
cd ..cd contracts
npx hardhat compile
cd ..cd contracts
npx hardhat compile
cd ..init
--show-stack-traces
npm test  # Runs across workspaces
cd contracts && npx hardhat test && cd ..cd gui
npm start  # Opens http://localhost:3000
npm run
gh repo clone East40Lisk/ACPN
pkg install gh
git clone git@github.com:East40Lisk/ACPN.git
git clone --depth 1 https://github.com/East40Lisk/ACPN.git
cd gui
npm start  # Opens http://localhost:3000

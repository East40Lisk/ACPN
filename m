name: CI

on:
  push:
    branches: [ main, feat/** ]
  pull_request:
    branches: [ main ]

jobs:
  build-and-test:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'

      - name: Install dependencies
        run: npm install

      - name: Setup Rust
        uses: actions/setup-rust@v1
        with:
          rust-version: stable

      - name: Install wasm-pack
        run: cargo install wasm-pack

      - name: Build WASM
        run: npm run build:wasm

      - name: Run tests
        run: npm test  # Runs Jest (SDK) + Hardhat tests via workspaces

      - name: Compile contracts
        run: cd contracts && npx hardhat compile

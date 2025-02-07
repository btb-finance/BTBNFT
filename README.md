<p align="center">
  <a href="https://layerzero.network">
    <img alt="LayerZero" style="width: 400px" src="https://docs.layerzero.network/img/LayerZero_Logo_White.svg"/>
  </a>
</p>

<p align="center">
  <a href="https://layerzero.network" style="color: #a77dff">Homepage</a> | <a href="https://docs.layerzero.network/" style="color: #a77dff">Docs</a> | <a href="https://layerzero.network/developers" style="color: #a77dff">Developers</a>
</p>

<h1 align="center">BTB NFT Project</h1>

<p align="center">
  <a href="https://docs.layerzero.network/v2/developers/evm/onft721/quickstart" style="color: #a77dff">Quickstart</a> | <a href="https://docs.layerzero.network/contracts/oapp-configuration" style="color: #a77dff">Configuration</a> | <a href="https://docs.layerzero.network/contracts/options" style="color: #a77dff">Message Execution Options</a> | <a href="https://docs.layerzero.network/contracts/endpoint-addresses" style="color: #a77dff">Endpoint Addresses</a>
</p>

<p align="center">A LayerZero-powered NFT collection that enables cross-chain NFT transfers using the ONFT721 standard.</p>

### ONFT721Adapter additional setup:

- In your `hardhat.config.ts` file, add the following configuration to the network you want to deploy the ONFT721Adapter to:
  ```typescript
  // Replace `0x0` with the address of the ERC721 token you want to adapt to the ONFT721 functionality.
  onft721Adapter: {
      tokenAddress: '0x0',
  }
  ```

## Deployed Contracts

- **Network**: OP Sepolia (Optimism Testnet)
- **Contract Address**: `0xA1C178304D40841703c454D43187E029dbf5173e`
- **Contract Name**: MyONFT721
- **Symbol**: ONFT
- **Block Explorer**: [View on Etherscan](https://sepolia-optimism.etherscan.io/address/0xA1C178304D40841703c454D43187E029dbf5173e#code)

## Features

- Cross-chain NFT transfers using LayerZero
- ERC721 standard compliance
- Customizable base URI for NFT metadata
- Configurable mint price in BTB tokens
- Owner-only minting functions
- Maximum supply cap of 10,000 NFTs

## Development

### Prerequisites

- Node.js
- pnpm (Package Manager)
- Hardhat

### Installation

```bash
# Install dependencies
pnpm install
```

### Configuration

1. Create a `.env` file based on `.env.example`
2. Set your private key or mnemonic
3. (Optional) Set RPC URLs for different networks

### Available Commands

```bash
# Compile contracts
pnpm hardhat compile

# Run tests
pnpm hardhat test

# Deploy to OP Sepolia
pnpm hardhat deploy --network op-sepolia

# Verify contract
pnpm hardhat verify --network op-sepolia <contract-address> <constructor-args>
```

## Contract Functions

### For Users
- `buyToken(uint256 tokenId)`: Buy an NFT using BTB tokens
- `tokenURI(uint256 tokenId)`: Get the metadata URI for a specific token

### For Owner
- `mint(address to, uint256 tokenId)`: Mint a new NFT (owner only)
- `safeMint(address to, uint256 tokenId)`: Safely mint a new NFT (owner only)
- `updateBaseURI(string calldata _newBaseURI)`: Update the base URI for token metadata
- `setBaseExtension(string memory _newBaseExtension)`: Update the file extension for token metadata

## LayerZero Integration

This project uses LayerZero's ONFT721 standard for cross-chain NFT transfers. The contract is deployed with the following LayerZero configuration:

- **LayerZero Endpoint (OP Sepolia)**: `0x6edce65403992e310a62460808c4b910d972f10f`
- **Main Chain ID**: 11155420 (OP Sepolia)

## License

UNLICENSED

## Security

This project is provided as-is. Please conduct your own security review before using any of the code in production.

## 1) Developing Contracts

#### Installing dependencies

We recommend using `pnpm` as a package manager (but you can of course use a package manager of your choice):

```bash
pnpm install
```

#### Compiling your contracts

This project supports both `hardhat` and `forge` compilation. By default, the `compile` command will execute both:

```bash
pnpm compile
```

If you prefer one over the other, you can use the tooling-specific commands:

```bash
pnpm compile:forge
pnpm compile:hardhat
```

Or adjust the `package.json` to for example remove `forge` build:

```diff
- "compile": "$npm_execpath run compile:forge && $npm_execpath run compile:hardhat",
- "compile:forge": "forge build",
- "compile:hardhat": "hardhat compile",
+ "compile": "hardhat compile"
```

#### Running tests

Similarly to the contract compilation, we support both `hardhat` and `forge` tests. By default, the `test` command will execute both:

```bash
pnpm test
```

If you prefer one over the other, you can use the tooling-specific commands:

```bash
pnpm test:forge
pnpm test:hardhat
```

Or adjust the `package.json` to for example remove `hardhat` tests:

```diff
- "test": "$npm_execpath test:forge && $npm_execpath test:hardhat",
- "test:forge": "forge test",
- "test:hardhat": "$npm_execpath hardhat test"
+ "test": "forge test"
```

## 2) Deploying Contracts

Set up deployer wallet/account:

- Rename `.env.example` -> `.env`
- Choose your preferred means of setting up your deployer wallet/account:

```
MNEMONIC="test test test test test test test test test test test junk"
or...
PRIVATE_KEY="0xabc...def"
```

- Fund this address with the corresponding chain's native tokens you want to deploy to.

To deploy your contracts to your desired blockchains, run the following command in your project's folder:

```bash
npx hardhat lz:deploy
```

More information about available CLI arguments can be found using the `--help` flag:

```bash
npx hardhat lz:deploy --help
```

By following these steps, you can focus more on creating innovative omnichain solutions and less on the complexities of cross-chain communication.

<br></br>

<p align="center">
  Join our community on <a href="https://discord-layerzero.netlify.app/discord" style="color: #a77dff">Discord</a> | Follow us on <a href="https://twitter.com/LayerZero_Labs" style="color: #a77dff">Twitter</a>
</p>

import assert from 'assert'

import { type DeployFunction } from 'hardhat-deploy/types'

const contractName = 'MyONFT721'

// LayerZero Endpoint address for OP Sepolia
const LZ_ENDPOINT_OP_SEPOLIA = "0x6edce65403992e310a62460808c4b910d972f10f"

const deploy: DeployFunction = async (hre) => {
    const { getNamedAccounts, deployments } = hre

    const { deploy } = deployments
    const { deployer } = await getNamedAccounts()

    assert(deployer, 'Missing named deployer account')

    console.log(`Network: ${hre.network.name}`)
    console.log(`Deployer: ${deployer}`)

    if (hre.network.config.onft721Adapter != null) {
        console.warn(`onft721Adapter configuration found on OFT deployment, skipping ONFT721 deployment`)
        return
    }

    // op sepolia
    const mainChainId = 11155420

    const { address } = await deploy(contractName, {
        from: deployer,
        args: [
            'MyONFT721', // name
            'ONFT', // symbol
            LZ_ENDPOINT_OP_SEPOLIA, // LayerZero's EndpointV2 address
            deployer, // owner
            mainChainId, // main chain ID where minting is allowed
            "0x0000000000000000000000000000000000000000", // BTB token address (placeholder)
            0 // initial price (placeholder)
        ],
        log: true,
        skipIfAlreadyDeployed: false,
    })

    console.log(`Deployed contract: ${contractName}, network: ${hre.network.name}, address: ${address}`)
}

deploy.tags = [contractName]

export default deploy

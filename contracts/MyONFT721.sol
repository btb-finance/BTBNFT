// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

import { ONFT721 } from "@layerzerolabs/onft-evm/contracts/onft721/ONFT721.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract MyONFT721 is ONFT721 {
    using Strings for uint256;

    string private baseURI;
    string public baseExtension = ".json";
    uint256 public immutable MAIN_CHAIN_ID;
    uint256 public constant MAX_SUPPLY = 10000;
    uint256 public totalMinted;
    
    IERC20 public btbToken;
    uint256 public mintPrice;
    
    event PriceUpdated(uint256 newPrice);
    event TokenSold(address buyer, uint256 tokenId, uint256 price);

    constructor(
        string memory _name,
        string memory _symbol,
        address _lzEndpoint,
        address _delegate,
        uint256 _mainChainId,
        address _btbToken,
        uint256 _initialPrice
    ) ONFT721(_name, _symbol, _lzEndpoint, _delegate) {
        MAIN_CHAIN_ID = _mainChainId;
        btbToken = IERC20(_btbToken);
        mintPrice = _initialPrice;
    }

    function getBaseURI() internal view returns (string memory) {
        return baseURI;
    }

    function updateBaseURI(string calldata _newBaseURI) external onlyOwner {
        baseURI = _newBaseURI;
    }

    function setBaseExtension(string memory _newBaseExtension) public onlyOwner {
        baseExtension = _newBaseExtension;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(ownerOf(tokenId) != address(0), "URI query for nonexistent token");

        string memory currentBaseURI = getBaseURI();
        return bytes(currentBaseURI).length > 0
            ? string(abi.encodePacked(currentBaseURI, tokenId.toString(), baseExtension))
            : "";
    }

    function mint(address to, uint256 tokenId) public onlyOwner {
        require(block.chainid == MAIN_CHAIN_ID, "Can only mint on main chain");
        require(totalMinted < MAX_SUPPLY, "Max supply reached");
        totalMinted++;
        _mint(to, tokenId);
    }

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        require(block.chainid == MAIN_CHAIN_ID, "Can only mint on main chain");
        require(totalMinted < MAX_SUPPLY, "Max supply reached");
        totalMinted++;
        _safeMint(to, tokenId);
    }

    function safeMint(address to, uint256 tokenId, bytes memory data) public onlyOwner {
        require(block.chainid == MAIN_CHAIN_ID, "Can only mint on main chain");
        require(totalMinted < MAX_SUPPLY, "Max supply reached");
        totalMinted++;
        _safeMint(to, tokenId, data);
    }
    
    function buyToken(uint256 tokenId) public {
        require(block.chainid == MAIN_CHAIN_ID, "Can only mint on main chain");
        require(mintPrice > 0, "Minting is not enabled");
        require(totalMinted < MAX_SUPPLY, "Max supply reached");
        require(btbToken.balanceOf(msg.sender) >= mintPrice, "Insufficient BTB balance");
        require(btbToken.allowance(msg.sender, address(this)) >= mintPrice, "Insufficient BTB allowance");
        
        require(btbToken.transferFrom(msg.sender, owner(), mintPrice), "BTB transfer failed");
        totalMinted++;
        _safeMint(msg.sender, tokenId);
        
        emit TokenSold(msg.sender, tokenId, mintPrice);
    }
}

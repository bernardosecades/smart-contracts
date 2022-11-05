// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "./Base64.sol";

// @see https://docs.openzeppelin.com/contracts/4.x/wizard
contract BerniePunksV3 is ERC721, ERC721Enumerable {
    using Counters for Counters.Counter;

    Counters.Counter private _idCounter;
    uint256 public maxSupply;

    constructor(uint256 _maxSupply) ERC721("BerniePunks", "BPKS") {
        maxSupply = _maxSupply;
    }

    function mint() public {
        uint256 current = _idCounter.current(); // secuential ID (our tokenID)
        require(current < maxSupply, "Max supply exceeded, no Bernie Punks left :(");
        _safeMint(msg.sender, current);
    }

    // we put view because we dont modify state of blockhacin and our user we wont spend gas to call this function
    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721 Metadata: URI query for nonexistent token"
        );

        //string memory jsonURI = string(abi.encodePacked("Hola", "Mundo"));
        // we can add more metadata no standard in 721 but extend platform like: https://docs.opensea.io/docs/metadata-standards
        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "BerniePunks#"',
                tokenId,
                '", "description": "Avatars stored on chain", "image": "',
                "//TODO calculate image URL",
                '"}'
            )
        );

        // Data URLs standard https://developer.mozilla.org/en-US/docs/Web/HTTP/Basics_of_HTTP/Data_URLs
        return string(
            abi.encodePacked(
                "data:application/json;base64,",
                jsonURI
            )
        );
    }

    // The following function is override required by Solidity (Enummerable)
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }

    // The following function is override required by Solidity (Enummerable)
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}

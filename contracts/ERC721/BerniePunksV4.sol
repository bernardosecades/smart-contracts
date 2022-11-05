// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "./Base64.sol";
import "./BerniePunksDNA.sol";

// @see https://docs.openzeppelin.com/contracts/4.x/wizard
contract BerniePunksV4 is ERC721, ERC721Enumerable, BerniePunksDNA {
    using Counters for Counters.Counter;
    using Strings for uint256; // overhead functionalities uint256

    Counters.Counter private _idCounter;
    uint256 public maxSupply;

    // tokenId => dna
    mapping(uint256 => uint256) public tokenDNA;

    constructor(uint256 _maxSupply) ERC721("BerniePunks", "BPKS") {
        maxSupply = _maxSupply;
    }

    function mint() public {
        uint256 current = _idCounter.current(); // secuential ID (our tokenID)
        require(current < maxSupply, "Max supply exceeded, no Bernie Punks left :(");

        tokenDNA[current] = deterministicPseudoRandomDNA(current, msg.sender);

        _safeMint(msg.sender, current);

        _idCounter.increment();
    }

    // overwrite
    function _baseURI() internal pure override returns(string memory) {
        return "https://avataaars.io/";
    }

    // custom
    function _paramsURI(uint256 _dna) internal view returns (string memory) {
        string memory paramsA;
        string memory paramsB;

        // new contex (block) to avoid compiler errors like: "Stack too deep ..."
        {
            paramsA = string(
                abi.encodePacked(
                    "accessoriesType=",
                    getAccessoriesType(_dna),
                    "&clotheColor=",
                    getClotheColor(_dna),
                    "&clotheType=",
                    getClotheType(_dna),
                    "&eyeType=",
                    getEyeType(_dna),
                    "&eyebrowType=",
                    getEyeBrowType(_dna),
                    "&facialHairColor=",
                    getFacialHairColor(_dna)
                )
            );
        }

        paramsB = string(
                abi.encodePacked(
                    "&facialHairType=",
                    getFacialHairType(_dna),
                    "&hairColor=",
                    getHairColor(_dna),
                    "&hatColor=",
                    getHatColor(_dna),
                    "&graphicType=",
                    getGraphicType(_dna),
                    "&mouthType=",
                    getMouthType(_dna),
                    "&skinColor=",
                    getSkinColor(_dna),
                    "&topType=",
                    getTopType(_dna)
                )
            );

        return string(abi.encodePacked(paramsA, paramsB));
    }

    // Generate preview from external or other contracts
    function imageByDNA(uint256 _dna) public view returns (string memory) {
        string memory baseURI = _baseURI();
        string memory paramsURI = _paramsURI(_dna);

        return string(abi.encodePacked(baseURI, "?", paramsURI));
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

        uint256 dna = tokenDNA[tokenId];
        string memory image = imageByDNA(dna);

        //string memory jsonURI = string(abi.encodePacked("Hola", "Mundo"));
        // we can add more metadata no standard in 721 but extend platform like: https://docs.opensea.io/docs/metadata-standards
        string memory jsonURI = Base64.encode(
            abi.encodePacked(
                '{ "name": "BerniePunks #',
                tokenId.toString(),
                '", "description": "Berni Punks are randomized Avataaars stored on chain", "image": "',
                image,
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

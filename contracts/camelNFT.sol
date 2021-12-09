pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "base64-sol/base64.sol";

contract CamelNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    // events
    event CreatedNFT(uint256 indexed tokenId, string tokenURI);

    constructor() ERC721("CamelNFT", "JML") {}

    function create() public {
        // take the current counter reading
        uint256 tokenId = _tokenIds.current();
        // mint the token
        _safeMint(msg.sender, tokenId);
        // token uri
        // generate the Token uri
        // for now it's static
        string memory tokenUri = formatTokenUri();
        // assign the token uri to the token id
        _setTokenURI(tokenId, tokenUri);
        // emit the minting
        emit CreatedNFT(tokenId, tokenUri);
        // increment the counter
        _tokenIds.increment();
    }

    function formatTokenUri() public pure returns (string memory) {
        string memory baseURL = "data:application/json;base64,";
        // for now it's static picture, the camel nft
        return
            string(
                abi.encodePacked(
                    baseURL,
                    Base64.encode(
                        bytes(
                            abi.encodePacked(
                                '{"name":"JML",',
                                '"description": "its a beautiful camel!",',
                                '"attributes" : "",',
                                '"image": "https://bafybeihzfooe47zgs2gktzvnvmhigxrbqux4jas6ezxsunlyvongm3k3ya.ipfs.infura-ipfs.io/"}'
                            )
                        )
                    )
                )
            );
    }

    function getCounter() public view returns (uint256) {
        uint256 counter = _tokenIds.current();

        return counter;
    }
}

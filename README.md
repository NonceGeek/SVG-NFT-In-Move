# SVG-NFT-in-Move

## Quick Start

**0x00 change acct in all `Move.toml` to your acct**

**0x01 compile**

```bash
cd contracts/svg-handler
mpm release
```

```bash
cd contracts/svg-nft
mpm release
```
**0x02 deploy**

```bash
starcoin% dev deploy [path to svg-handler blob compiled]
```

```bash
starcoin% dev deploy [path to svg-nft blob compiled]
```

**0x03 init contract**

```bash
starcoin% account execute-function --function 0xabcde::SVGNFTScripts::initialize -b
```
**0x04 run test script**

```bash
starcoin% account execute-function --function [ur-acct]::SVGNFTScripts::test_mint_with_auto_svg -b
```

log info:
<img width="671" alt="image" src="https://user-images.githubusercontent.com/12784118/153893698-ff51c566-59c9-49ef-a4ef-8a6d5660953f.png">

SVG decoded:
<img width="1438" alt="image" src="https://user-images.githubusercontent.com/12784118/153996540-47d16ec7-4578-42f2-b2a9-7fc47f3a8957.png">


## Work Details

Do 2 Parts of Work in Move Language for Starcoin Network.

- Impl a SVG Module for the eazy use of SVG in Move Contracts

  > https://github.com/WeLightProject/SVG-NFT-in-Move/tree/main/contracts/svg-handler
  
  funcs in svg-handler:
  
  - build_svg(x: u64, y: u64, fill: vector<u8>, payload: vector<u8>) : vector<u8>
    
    build a new svg by payload.
    
  - build_a_line(x: u64, y: u64, payload: vector<u8>) : vector<u8>
    
    build a line of word by x,y and word --- just as loot in Ethereum.
    
  - draw_a_circle(x: u64, y: u64, r: u64, stroke: vector<u8>,  stroke_width: vector<u8>, stroke_fill: vector<u8>) : vector<u8>
    
    draw a circle in svg.
    
  - fun draw_a_rec(x: u64, y: u64, width: u64, height: u64, stroke: vector<u8>, stroke_width: vector<u8>, stroke_fill: vector<u8>) : vector<u8>
    
    draw a rect in svg.
  
- Impl an loot-live example in svg-nft:
  
  > https://github.com/WeLightProject/SVG-NFT-in-Move/tree/main/contracts/svg-nft
  
  funcs in svg-nft:
  
  - build_loot_svg(id: u64): vector<u8>
  
    generate a simple loot svg.
  
  - fun mint_with_auto_svg(sender: &signer, name: vector<u8>, description: vector<u8>): NFT<SVGNFT, SVGNFTBody> acquires SVGNFTMintCapability
  
    the way to mint a svg nft.
  
  scripts in svg-nft:
  
  - public(script) fun test_mint_with_auto_svg(sender: signer)
  
    test to mint an svg nft.

- TODO List:
  
  - **dApp:** Impl an dApp for this contract.
  - **using b64 encode/decode:** using b64 for image encode/decode.
    
 
## Contracts deployed on Barnard
  
SVGHandler: https://stcscan.io/barnard/transactions/detail/0x26311b93f868169efcb0876ebaeea05962e4e690d8d3bc5e4a46cac3c820993a
  
SVGNFT: https://stcscan.io/barnard/transactions/detail/0x2aeb0b1ac276c1fafe33d00a2f2eac04577d2c7c2b9c238f03445b99392cc51b
  
  

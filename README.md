# SVG-NFT-in-Move

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
    
    
  
  

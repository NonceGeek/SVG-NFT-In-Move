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
    
    
  
  

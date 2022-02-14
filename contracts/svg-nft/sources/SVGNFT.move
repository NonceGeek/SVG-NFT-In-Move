module  SNFT::SVGNFT{
	use StarcoinFramework::NFT::{Self, NFT, MintCapability, BurnCapability, UpdateCapability, Metadata, NFTInfo};
	use StarcoinFramework::Signer;
	use StarcoinFramework::NFTGallery;
	use StarcoinFramework::Option::Option;
	use StarcoinFramework::Vector;
	use StarcoinFramework::BCS;
	use StarcoinFramework::Hash;

	use SvgHandler::SvgHandler;
	
	struct SVGNFT has copy, store, drop{
	}

	struct SVGNFTBody has store{}

	struct SVGNFTMintCapability has key{
        	cap: MintCapability<SVGNFT>,
    	}

	struct SVGNFTBurnCapability has key{
		cap: BurnCapability<SVGNFT>,
	}

	struct SVGNFTUpdateCapability has key{
		cap: UpdateCapability<SVGNFT>,
	}

	const CONTRACT_ACCOUNT:address = @SNFT;

	public fun generate_thing(pos: vector<u8>, id: u64) : vector<u8> {
		BCS::to_bytes(&Self::do_generate_thing(pos, id))
	}
		
	public fun do_generate_thing(pos: vector<u8>, id: u64) : u8 {
		let payload = Vector::empty();
		Vector::append(&mut payload, pos);
		Vector::append(&mut payload, BCS::to_bytes(&id));
		Vector::pop_back(&mut Hash::sha2_256(payload))
	}

	public fun build_loot_svg(_id: u64): vector<u8> {
		let payload = Vector::empty();
		Vector::append(&mut payload, SvgHandler::build_a_line(10, 20, b"HEAD"));
		Vector::append(&mut payload, SvgHandler::build_a_line(10, 40, b"BODY"));
		Vector::append(&mut payload, SvgHandler::build_a_line(10, 60, b"FOOT"));
		SvgHandler::build_svg(350, 350, b"green", payload)
	}

	public fun initialize(sender: &signer) {
		assert!(Signer::address_of(sender)==CONTRACT_ACCOUNT, 101);
		
		if(!exists<SVGNFTMintCapability>(CONTRACT_ACCOUNT)) {
			let meta = NFT::new_meta_with_image_data(b"SVGNFT", b"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6Y2M9Imh0dHA6Ly93ZWIucmVzb3VyY2Uub3JnL2NjLyIgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIiB4bWxuczpzb2RpcG9kaT0iaHR0cDovL3NvZGlwb2RpLnNvdXJjZWZvcmdlLm5ldC9EVEQvc29kaXBvZGktMC5kdGQiIHhtbG5zOmlua3NjYXBlPSJodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy9uYW1lc3BhY2VzL2lua3NjYXBlIiB2ZXJzaW9uPSIxLjEiIGJhc2VQcm9maWxlPSJmdWxsIiB3aWR0aD0iMTUwcHgiIGhlaWdodD0iMTUwcHgiIHZpZXdCb3g9IjAgMCAxNTAgMTUwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWlkWU1pZCBtZWV0IiBpZD0ic3ZnX2RvY3VtZW50IiBzdHlsZT0iem9vbTogMTsiPjwhLS0gQ3JlYXRlZCB3aXRoIG1hY1NWRyAtIGh0dHBzOi8vbWFjc3ZnLm9yZy8gLSBodHRwczovL2dpdGh1Yi5jb20vZHN3YXJkMi9tYWNzdmcvIC0tPjx0aXRsZSBpZD0ic3ZnX2RvY3VtZW50X3RpdGxlIj5VbnRpdGxlZC5zdmc8L3RpdGxlPjxkZWZzIGlkPSJzdmdfZG9jdW1lbnRfZGVmcyI+PC9kZWZzPjxnIGlkPSJtYWluX2dyb3VwIj48cmVjdCBpZD0iYmFja2dyb3VuZF9yZWN0IiBmaWxsPSIjMTU4OGYxIiB4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjE1MHB4IiBoZWlnaHQ9IjE1MHB4Ij48L3JlY3Q+PC9nPjwvc3ZnPg==", b"A NFT example, everyone can mint a SVGNFT");
			NFT::register_v2<SVGNFT>(sender, meta);
			let cap = NFT::remove_mint_capability<SVGNFT>(sender);
			move_to(sender, SVGNFTMintCapability{ cap});

			let cap = NFT::remove_burn_capability<SVGNFT>(sender);
			move_to(sender, SVGNFTBurnCapability{ cap});

			let cap = NFT::remove_update_capability<SVGNFT>(sender);
			move_to(sender, SVGNFTUpdateCapability{ cap});
		}
	}

	// https://rustwiki.org/zh-CN/rust-by-example/error/option_unwrap/question_mark.html
	/* NFTInfo
		id: u64,
        creator: address,
        base_meta: Metadata,
        type_meta: NFTMeta,
	*/
	/* Metadata
        name: vector<u8>,
        /// Image link, such as ipfs://xxxx
        image: vector<u8>,
        /// Image bytes data, image or image_data can not empty for both.
        image_data: vector<u8>,
        /// NFT description utf8 bytes.
        description: vector<u8>,
	*/
	public fun get_nft_info_by_id(owner: address, id: u64):Option<NFTInfo<SVGNFT>>{
		NFTGallery::get_nft_info_by_id<SVGNFT, SVGNFTBody>(owner, id)
	}

	/*
		get info list of nft by owner.
	*/
	public fun get_nft_infos(owner: address): vector<NFTInfo<SVGNFT>>{
		NFTGallery::get_nft_infos<SVGNFT, SVGNFTBody>(owner)
	}

	public fun mint(sender: &signer, metadata: Metadata): NFT<SVGNFT, SVGNFTBody> acquires SVGNFTMintCapability{
		let mint_cap = borrow_global_mut<SVGNFTMintCapability>(CONTRACT_ACCOUNT);
		let nft = NFT::mint_with_cap_v2<SVGNFT,SVGNFTBody>(Signer::address_of(sender), &mut mint_cap.cap, metadata, SVGNFT{}, SVGNFTBody{});
		nft
	}

	public fun mint_with_auto_svg(sender: &signer, name: vector<u8>, description: vector<u8>): NFT<SVGNFT, SVGNFTBody> acquires SVGNFTMintCapability{
		let mint_cap = borrow_global_mut<SVGNFTMintCapability>(CONTRACT_ACCOUNT);
		let token_id: u64 = NFT::nft_type_info_counter_v2<SVGNFT>();
		let svg: vector<u8> = Self::build_loot_svg(token_id);
		let metadata = NFT::new_meta_with_image_data(name, svg, description);
		let nft = NFT::mint_with_cap_v2<SVGNFT,SVGNFTBody>(Signer::address_of(sender), &mut mint_cap.cap, metadata, SVGNFT{}, SVGNFTBody{});
		nft
	}

	public fun accept(sender: &signer){
		NFTGallery::accept<SVGNFT, SVGNFTBody>(sender);
	}

}

module SNFT::SVGNFTScripts{
	use StarcoinFramework::NFT;
	use StarcoinFramework::NFTGallery;
	use SNFT::SVGNFT;
	use StarcoinFramework::Debug;
	use StarcoinFramework::Signer;

	public(script) fun initialize(sender: signer) {
		SVGNFT::initialize(&sender);
		SVGNFT::accept(&sender);
	}

	public(script) fun accept(sender: signer){
		SVGNFT::accept(&sender);
	}

	public(script) fun test_mint_with_image(sender: signer){
		let name = b"test nft";
		let description = b"test description";
		let image_url = b"ipfs:://QmSPcvcXgdtHHiVTAAarzTeubk5X3iWymPAoKBfiRFjPMY";
		Self::mint_with_image(sender, name, image_url, description);
	}

	public(script) fun mint_with_image(sender: signer, name: vector<u8>, image_url: vector<u8>, description: vector<u8>){
		let metadata = NFT::new_meta_with_image(name, image_url, description);
		let nft = SVGNFT::mint(&sender, metadata);
		NFTGallery::deposit(&sender, nft);
	}

	public(script) fun test_mint_with_image_data(sender: signer){
		let name = b"test nft";
		let description = b"test description";
		let image_data =  b"data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBlbmNvZGluZz0idXRmLTgiIHN0YW5kYWxvbmU9InllcyI/Pgo8IURPQ1RZUEUgc3ZnIFBVQkxJQyAiLS8vVzNDLy9EVEQgU1ZHIDEuMS8vRU4iICJodHRwOi8vd3d3LnczLm9yZy9HcmFwaGljcy9TVkcvMS4xL0RURC9zdmcxMS5kdGQiPgo8c3ZnIHhtbG5zPSJodHRwOi8vd3d3LnczLm9yZy8yMDAwL3N2ZyIgeG1sbnM6eGxpbms9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkveGxpbmsiIHhtbG5zOmRjPSJodHRwOi8vcHVybC5vcmcvZGMvZWxlbWVudHMvMS4xLyIgeG1sbnM6Y2M9Imh0dHA6Ly93ZWIucmVzb3VyY2Uub3JnL2NjLyIgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIiB4bWxuczpzb2RpcG9kaT0iaHR0cDovL3NvZGlwb2RpLnNvdXJjZWZvcmdlLm5ldC9EVEQvc29kaXBvZGktMC5kdGQiIHhtbG5zOmlua3NjYXBlPSJodHRwOi8vd3d3Lmlua3NjYXBlLm9yZy9uYW1lc3BhY2VzL2lua3NjYXBlIiB2ZXJzaW9uPSIxLjEiIGJhc2VQcm9maWxlPSJmdWxsIiB3aWR0aD0iMTUwcHgiIGhlaWdodD0iMTUwcHgiIHZpZXdCb3g9IjAgMCAxNTAgMTUwIiBwcmVzZXJ2ZUFzcGVjdFJhdGlvPSJ4TWlkWU1pZCBtZWV0IiBpZD0ic3ZnX2RvY3VtZW50IiBzdHlsZT0iem9vbTogMTsiPjwhLS0gQ3JlYXRlZCB3aXRoIG1hY1NWRyAtIGh0dHBzOi8vbWFjc3ZnLm9yZy8gLSBodHRwczovL2dpdGh1Yi5jb20vZHN3YXJkMi9tYWNzdmcvIC0tPjx0aXRsZSBpZD0ic3ZnX2RvY3VtZW50X3RpdGxlIj5VbnRpdGxlZC5zdmc8L3RpdGxlPjxkZWZzIGlkPSJzdmdfZG9jdW1lbnRfZGVmcyI+PC9kZWZzPjxnIGlkPSJtYWluX2dyb3VwIj48cmVjdCBpZD0iYmFja2dyb3VuZF9yZWN0IiBmaWxsPSIjMTU4OGYxIiB4PSIwcHgiIHk9IjBweCIgd2lkdGg9IjE1MHB4IiBoZWlnaHQ9IjE1MHB4Ij48L3JlY3Q+PC9nPjwvc3ZnPg==";
		Self::mint_with_image_data(sender, name, image_data, description);
	}

	public(script) fun test_mint_with_auto_svg(sender: signer){
		let name = b"test loot nft";
		let description = b"test loot description";
		Self::mint_with_auto_svg(sender, name, description);
	}

	public(script) fun mint_with_auto_svg(sender: signer, name: vector<u8>, description: vector<u8>){
		let nft = SVGNFT::mint_with_auto_svg(&sender, name, description);
		Debug::print(&nft);
		NFTGallery::deposit(&sender, nft);
	}

	public(script) fun mint_with_image_data(sender: signer, name: vector<u8>, image_data: vector<u8>, description: vector<u8>){
		let metadata = NFT::new_meta_with_image_data(name, image_data, description);
		let nft = SVGNFT::mint(&sender,metadata);
		NFTGallery::deposit(&sender, nft);
	}

	public(script) fun test_get_nft_info_by_id(sender: signer){
		let nft_id = 1;
		let acct = Signer::address_of(&sender);
		Self::get_nft_info_by_id(acct, nft_id);
	}

	public(script) fun test_get_nft_infos(sender: signer){
		let acct = Signer::address_of(&sender);
		Self::get_nft_infos(acct);
	}
	public(script) fun get_nft_infos(owner: address) {
		let nfts = NFTGallery::get_nft_infos<SVGNFT::SVGNFT, SVGNFT::SVGNFTBody>(owner);
		Debug::print(&nfts);
	}
	public(script) fun get_nft_info_by_id(owner: address, id: u64) {
		let nft = NFTGallery::get_nft_info_by_id<SVGNFT::SVGNFT, SVGNFT::SVGNFTBody>(owner, id);
		Debug::print(&nft);
	}
}

// script {
// 	use StarcoinFramework::Debug;
// 	use StarcoinFramework::Signer;
// 	fun log_acct(account: signer) {
// 		let acct = Signer::address_of(&account);
// 		Debug::print(&acct)
// 	}
module  SvgHandler::SvgHandler{
	use StarcoinFramework::Vector;

    const HEADER: vector<u8> = b"aha";
    const TAIL: vector<u8> = b"aha";

    struct SvgGallery has key, store{
        items: vector<SvgResource>,
    }
	struct SvgResource has key, copy, store,drop{
        /// payload of the resource
        id: u64,
        payload: vector<u8>,
	}

    /*
        https://diem.github.io/move/functions.html?highlight=acquire#acquires
    */
    public fun get_encoded_svg(id: u64) : () acquires SvgResource {
        // let a: vector<u8> = b"aha";
        // let b: vector<u8> = b"aha";
        let gallery = borrow_global_mut<SvgGallery>(@SvgHandler);
        // TODO: impl by watch:
        // https://github.com/starcoinorg/starcoin/blob/13d2c9ee658bebf9d7297ad498c7efc161aa0a17/vm/stdlib/sources/NFT.move
        // 727
        let svg_resource = find_by_id<SvgResource>(&gallery.items, id);
        let vec1 = Vector::append(&mut HEADER, svg_resource);
        Vector::append(&mut vec1, TAIL)
    }

    
    // public fun get_payload_encoded(): vector<u8> {
    // }
}
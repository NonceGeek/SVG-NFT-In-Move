module  SvgHandler::SvgHandler{
	use StarcoinFramework::Vector;
    use StarcoinFramework::BCS;

    // const HEADER: vector<u8> = b"<svg xmlns=\"http://www.w3.org/2000/svg\" preserveAspectRatio=\"xMinYMin meet\" viewBox=\"0 0 350 350\"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width=\"100%\" height=\"100%\" fill=\"black\" />";
    // const TAIL: vector<u8> = b"</svg>";

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
    // public fun get_raw_svg(id: u64) : () acquires SvgGallery {
    //     // let a: vector<u8> = b"aha";
    //     // let b: vector<u8> = b"aha";
    //     let gallery = borrow_global_mut<SvgGallery>(@SvgHandler);
    //     // TODO: impl by watch:
    //     // https://github.com/starcoinorg/starcoin/blob/13d2c9ee658bebf9d7297ad498c7efc161aa0a17/vm/stdlib/sources/NFT.move
    //     // 727 line
    //     // let svg_resource = find_by_id<SvgResource>(&gallery.items, id);
    //     // let svg_resource = b"test";
    //     // let vec1 = Vector::append(&mut HEADER, svg_resource);
    //     Vector::append(&mut HEADER, TAIL)
    // }

    public fun build_svg(x: u64, y: u64, fill: vector<u8>, payload: vector<u8>) : vector<u8>{
        let result = Vector::empty();
        Vector::append(&mut result, b"<svg xmlns=\"http://www.w3.org/2000/svg\" preserveAspectRatio=\"xMinYMin meet\" viewBox=\");
        Vector::append(&mut result, BCS::to_bytes(&x));
        Vector::append(&mut result, b" ");
        Vector::append(&mut result, BCS::to_bytes(&y));
        Vector::append(&mut result, b"\"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width=\"100%\" height=\"100%\" fill=\"");
        Vector::append(&mut result, fill);
        Vector::append(&mut result, b"\" />");
        Vector::append(&mut result, svg_resource);
        // https://www.coder.work/article/2553624
        Vector::append(&mut result, TAIL);
        result
    }

    public fun build_a_line(x: u64, y: u64, payload: vector<u8>) : vector<u8> {
        let result = Vector::empty();
        Vector::append(&mut result, b"<text x=\"");
        Vector::append(&mut result, BCS::to_bytes(&x));
        Vector::append(&mut result, b"\" y=\"");
        Vector::append(&mut result, BCS::to_bytes(&y));
        Vector::append(&mut result, b"\" class=\"base\">");
        Vector::append(&mut result, payload);
        Vector::append(&mut result, b"</text>");
        result
    }

    public fun draw_a_circle(
        x: u64, 
        y: u64, 
        r: u64, 
        stroke: vector<u8>,  
        stroke_width: vector<u8>, 
        stroke_fill: vector<u8>) : vector<u8> {
        let result = Vector::empty();
        Vector::append(&mut result, b"circle cx=\"");
        Vector::append(&mut result, BCS::to_bytes(&x));
        Vector::append(&mut result, b"\" cy=\"");
        Vector::append(&mut result, BCS::to_bytes(&y));
        Vector::append(&mut result, b"\" r=\"");
        Vector::append(&mut result, BCS::to_bytes(&r));
        Vector::append(&mut result, b"\" stroke=\"");
        Vector::append(&mut result, stroke);
        Vector::append(&mut result, b"\" stroke-width=\"");
        Vector::append(&mut result, stroke_width);
        Vector::append(&mut result, b"\" fill=\"");
        Vector::append(&mut result, stroke_fill);
        Vector::append(&mut result, b"\" />");
        result
    }

    public fun draw_a_rec(
        x: u64,
        y: u64,
        width: u64,
        height: u64,
        stroke: vector<u8>,
        stroke_width: vector<u8>, 
        stroke_fill: vector<u8>) : vector<u8> {

        let result = Vector::empty();
        Vector::append(&mut result, b"rect x=\"");
        Vector::append(&mut result, BCS::to_bytes(&x));
        Vector::append(&mut result, b"\" y=\"");
        Vector::append(&mut result, BCS::to_bytes(&y));
        Vector::append(&mut result, b"\" width=\"");
        Vector::append(&mut result, BCS::to_bytes(&width));
        Vector::append(&mut result, b"\" height=\"");
        Vector::append(&mut result, BCS::to_bytes(&height));
        Vector::append(&mut result, b"\" stroke=\"");
        Vector::append(&mut result, stroke);
        Vector::append(&mut result, b"\" stroke-width=\"");
        Vector::append(&mut result, stroke_width);
        Vector::append(&mut result, b"\" fill=\"");
        Vector::append(&mut result, stroke_fill);
        Vector::append(&mut result, b"\" />");
        result
    }
}
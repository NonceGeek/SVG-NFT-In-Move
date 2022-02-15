module  SvgHandler::SvgHandler{
	use StarcoinFramework::Vector;

    const ASCII_0: u8 = 48;

    struct SvgGallery has key, store{
        items: vector<SvgResource>,
    }
	struct SvgResource has key, copy, store,drop{
        /// payload of the resource
        id: u64,
        payload: vector<u8>,
	}

    public fun to_string_u8(num: u8):vector<u8> {
        let buf = Vector::empty<u8>();
        let i = num;
        let remainder:u8;
        loop{
            remainder = ((i % 10) as u8);
            Vector::push_back(&mut buf, ASCII_0 + remainder);
            i = i /10;
            if(i == 0){
                break
            };
        };
        Vector::reverse(&mut buf);
        buf
    }
    
    public fun to_string(num: u64):vector<u8> {
        let buf = Vector::empty<u8>();
        let i = num;
        let remainder:u8;
        loop{
            remainder = ((i % 10) as u8);
            Vector::push_back(&mut buf, ASCII_0 + remainder);
            i = i /10;
            if(i == 0){
                break
            };
        };
        Vector::reverse(&mut buf);
        buf
    }

    public fun build_svg(x: u64, y: u64, fill: vector<u8>, payload: vector<u8>) : vector<u8>{
        let result = Vector::empty();
        // https://www.coder.work/article/2553624
        Vector::append(&mut result, b"<svg xmlns=\"http://www.w3.org/2000/svg\" preserveAspectRatio=\"xMinYMin meet\" viewBox=\"");
        Vector::append(&mut result, Self::to_string(x));
        Vector::append(&mut result, b" ");
        Vector::append(&mut result, Self::to_string(y));
        Vector::append(&mut result, b"\"><style>.base { fill: white; font-family: serif; font-size: 14px; }</style><rect width=\"100%\" height=\"100%\" fill=\"");
        Vector::append(&mut result, fill);
        Vector::append(&mut result, b"\" />");
        Vector::append(&mut result, payload);
        Vector::append(&mut result, b"</svg>");
        result
    }

    public fun build_a_line(x: u64, y: u64, payload: vector<u8>) : vector<u8> {
        let result = Vector::empty();
        Vector::append(&mut result, b"<text x=\"");
        Vector::append(&mut result, Self::to_string(x));
        Vector::append(&mut result, b"\" y=\"");
        Vector::append(&mut result, Self::to_string(y));
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
        Vector::append(&mut result, Self::to_string(x));
        Vector::append(&mut result, b"\" cy=\"");
        Vector::append(&mut result, Self::to_string(y));
        Vector::append(&mut result, b"\" r=\"");
        Vector::append(&mut result, Self::to_string(r));
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
        Vector::append(&mut result, Self::to_string(x));
        Vector::append(&mut result, b"\" y=\"");
        Vector::append(&mut result, Self::to_string(y));
        Vector::append(&mut result, b"\" width=\"");
        Vector::append(&mut result, Self::to_string(width));
        Vector::append(&mut result, b"\" height=\"");
        Vector::append(&mut result, Self::to_string(height));
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
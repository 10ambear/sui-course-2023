module store::pie_store {
    use std::string::{Self, String};

    const ENoFlavor : u64 = 1;

    public struct Pie has key {
        id: UID,
        flavor: Flavor
    }

    public struct Flavor has store {
        flavor: String
    }

    public entry fun buy_pie(option: u8, ctx: &mut TxContext) {
        // select the flavor
        let mut flavor: String = string::utf8(b"pepper steak");
        if (option == 1) {
            flavor = string::utf8(b"pepper steak");
        } else if (option == 2) {
            flavor = string::utf8(b"ham and cheese");
        } else if (option == 3) {
            flavor = string::utf8(b"chicken and mushroom");
        } else {
            assert!(false, ENoFlavor);
        };

        // prepare the bread
        let pie = Pie {
            id: object::new(ctx), 
            flavor: Flavor {flavor: flavor}
        };

        // transfer Bread to customer
        transfer::transfer(pie, tx_context::sender(ctx));
    }


}

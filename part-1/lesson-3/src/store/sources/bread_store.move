module store::bread_store {
    use std::string::{Self, String};

    const ENoFlavor : u64 = 1;

    public struct Bread has key {
        id: UID,
        flavor: Flavor
    }

    // done: define the Sandwich struct
    public struct Sandwich has key {
        id: UID,
        flavor: Flavor
    }

    public struct Flavor has store {
        flavor: String
    }

    public entry fun buy_bread(option: u8, ctx: &mut TxContext) {
        // select the flavor
        let mut flavor: String = string::utf8(b"original");
        if (option == 1) {
            flavor = string::utf8(b"original");
        } else if (option == 2) {
            flavor = string::utf8(b"cheese toast");
        } else if (option == 3) {
            flavor = string::utf8(b"with butter");
        } else {
            assert!(false, ENoFlavor);
        };

        // prepare the bread
        let bread = Bread {
            id: object::new(ctx),
            flavor: Flavor {flavor: flavor}
        };

        // transfer Bread to customer
        transfer::transfer(bread, tx_context::sender(ctx));
    }

    public entry fun buy_sandwich(option: u8, ctx: &mut TxContext) {
        // TODO: implement this function, supporting flavors: mixed meat sandwich, chicken sandwich, cheese sandwich, and more
       let mut flavor: String = string::utf8(b"mixed meat sandwich");
        if (option == 1) {
            flavor = string::utf8(b"mixed meat sandwich");
        } else if (option == 2) {
            flavor = string::utf8(b"chicken sandwich");
        } else if (option == 3) {
            flavor = string::utf8(b"cheese sandwich");
        } else {
            assert!(false, ENoFlavor);
        };
        
        // prepare the sandwich
        let sandwich = Sandwich {
            id: object::new(ctx),
            flavor: Flavor {flavor: flavor}
        };

        // transfer Bread to customer
        transfer::transfer(sandwich, tx_context::sender(ctx));
    }
}

/// Module: hello_world
module hello_world::hello_world {
    use std::string::{Self, String};
 
    public struct HelloWorldObject has key {
        id:UID,
        text: String
    }

    public entry fun mint(ctx: &mut TxContext) {
        let object = HelloWorldObject {
            id: object::new(ctx),
            text: string::utf8(b"Hello World!")
        };
        transfer::transfer(object, tx_context::sender(ctx));
    }

    public entry fun my_mint(ctx: &mut TxContext) {
        let object = HelloWorldObject {
            id: object::new(ctx),
            text: string::utf8(b"I like SUI Move")
        };
        transfer::transfer(object, tx_context::sender(ctx));
    }
}


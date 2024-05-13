#[lint_allow(self_transfer)]
module cardgame::cardgame {

    // Define a Card object with id and power properties
    public struct Card has key, store {
        id: UID,
        power: u8,
    }


    // Define a Player object with id and a hand that can hold a card
    public struct Player has key {
        id: UID,
        hand: Option<Card>,
    }


    // A function to create a new card with a specific power
    public entry fun create_card(power: u8, ctx: &mut TxContext) {
        let card = Card {
        id: object::new(ctx),
        power,
        };
        transfer::transfer(card, tx_context::sender(ctx))
    }


    // A function to create a new player
    public entry fun create_player(ctx: &mut TxContext) {
        let player = Player {
        id: object::new(ctx),
        hand: option::none(),// A player starts with no card in hand
        };

        // Transfer the new player to the sender of the transaction
        transfer::transfer(player, tx_context::sender(ctx))
    }


    // A function for a player to draw a card
    public entry fun draw_card(player: &mut Player, card: Card, ctx: &mut TxContext) {
        // If the player already has a card in hand
        if (option::is_some(&player.hand)) {
            // Take the old card from the player's hand
            let old_card = option::extract(&mut player.hand);
            // Transfer the old card back to the sender
            transfer::transfer(old_card, tx_context::sender(ctx));
        };
        // Put the new card into the player's hand
        option::fill(&mut player.hand, card);
    }


    // Swap cards between two players
    public entry fun swap_cards(player1: &mut Player, player2: &mut Player) {
        let card1 = option::extract(&mut player1.hand);
        let card2 = option::extract(&mut player2.hand);
        option::fill(&mut player1.hand, card2);
        option::fill(&mut player2.hand, card1);
    }
}


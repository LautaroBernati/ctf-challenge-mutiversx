#![no_std]

use multiversx_sc::imports::*;

#[multiversx_sc::contract]
pub trait CtfBump {
    // Storage for a single bump counter
    #[view(bumpCount)]
    #[storage_mapper("bumpCount")]
    fn bump_count(&self) -> SingleValueMapper<u64>;

    #[init]
    fn init(&self) {
        self.bump_count().set(0);
    }

	#[upgrade]
    fn upgrade(&self) {}

    #[endpoint(bump)]
    fn bump(&self) {
        let current_count = self.bump_count().get();
        self.bump_count().set(current_count + 1);
    }

    #[endpoint(bumpMultiple)]
    fn bump_multiple(&self, count: u64) {
        let current_count = self.bump_count().get();
        self.bump_count().set(current_count + count);
    }
}

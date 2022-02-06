import { BigInt } from "@graphprotocol/graph-ts";
import { Purchase } from "../..//generated/Escrow/Escrow";
import { DealPurchase } from "../../generated/schema";

export function handlePurchase(event: Purchase): void {
  const entity = new DealPurchase(event.address.toHexString());
  entity.transaction = entity.transaction;
  entity.productId = event.params.param0;
  // entity.value = event.params.param1;
  entity.buyer = event.params.param2;
  entity.seller = event.params.param3;

  entity.save();
}

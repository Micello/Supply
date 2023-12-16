// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.25 <0.9.0;

import "./Types.sol";
import "./Lots.sol";
contract oss is Lots{

    function add_transaction(
        Types.Transaction memory transaction_,
        string memory barcodeId_, // Per aggiungere in lotHistory,
        uint256 currentTime_ // anche questo per lotHistory
    ) internal LotExists(barcodeId_) {
        transactions.push(transaction_);
        Types.Lot memory lot_ = lot[barcodeId_];
        lotHistory[lot_.barcodeId].usershistory.push(Types.UserHistory({
            id_: msg.sender,
            date: currentTime_,
            stockdate: 0,
            action: Types.Action.transaction
}));



    }
}
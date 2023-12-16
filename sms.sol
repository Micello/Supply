// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.25 <0.9.0;

import "./Types.sol";
import "./Lots.sol";
contract sms is Lots{

function update_StockDate(string memory barcodeId_, uint256 newStockDate) internal LotExists(barcodeId_) {
    Types.Lot storage lot_ = lot[barcodeId_];
    Types.UserHistory memory newUserHistory = Types.UserHistory({
        id_: msg.sender,
        date: block.timestamp,
        stockdate: newStockDate,
        action: Types.Action.update  // Assuming a default action or replace with your logic
    });

    // Push the new UserHistory entry to the usershistory array
    lotHistory[lot_.barcodeId].usershistory.push(newUserHistory);
}
}



    

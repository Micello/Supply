// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.25 <0.9.0;

import "./Lots.sol";
import "./Users.sol";
import "./oss.sol";
import "./sms.sol";
contract SupplyChain is Users, Lots, oss, sms {

    function addLot(Types.Lot memory lot_, uint256 currentTime_)
        public
        userExists
        onlyManufacturers
    {

        addALot(lot_, currentTime_);
    }
    
    function addTransaction(Types.Transaction memory transaction_,string memory barcodeId_, uint256 currentTime_)
        public
        userExists
    {
        add_transaction(transaction_, barcodeId_, currentTime_);
    }

        function updateStockdate(string memory barcodeId_, uint256 newStockDate)
        public
        userExists
        hasRole(Types.UserRole.database)
    {
        update_StockDate(barcodeId_, newStockDate);
    }

    function getAllTransactions() public view returns (Types.Transaction[] memory) {
        return transactions;
    }

    function getAllLots() public view returns (Types.Lot[] memory) {
        return lots;
    }

    function getMyLots() public view userExists returns (Types.Lot[] memory) {
        return getUserLots();
    }

        function getSingleLot(string memory barcodeId_)
        public
        view
        LotExists(barcodeId_)
        returns (Types.Lot memory)
    {
        return getSpecificLot(barcodeId_);
    }

    function getSingleLotHistory(string memory barcodeId_)
        public
        view
        LotExists(barcodeId_)
        returns (Types.Lot memory, Types.LotHistory memory)
    {
        return getSpecificLotHistory(barcodeId_);
    }

    function getUserDetails(address id_)
        public
        view
        otherUserExists(id_)
        returns (Types.UserDetails memory)
    {
        return users[id_];
    }

    function getMyDetails() public view userExists returns (Types.UserDetails memory) {
        return users[msg.sender];
    }
    
}

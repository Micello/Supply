// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.25 <0.9.0;

import "./Types.sol";

contract Lots {
    Types.Lot[] internal lots;
    Types.Transaction[] internal transactions;
    mapping(string => Types.Lot) internal lot;
    mapping(address => string[]) internal userLinkedLots;
    mapping(string => Types.LotHistory) internal lotHistory; //ogni lotto ha la propria history

    // Events

    event NewLot(
        uint256 id_lot,
        string barcodeId,
        address lot_user_addr,
        string source,
        string variety,
        string quality, 
        uint256 temprature, 
        uint256 humidity,
        uint256 date
    );


    function getUserLots() internal view returns (Types.Lot[] memory) {
        string[] memory ids_ = userLinkedLots[msg.sender];
        Types.Lot[] memory lots_ = new Types.Lot[](ids_.length);
        for (uint256 i = 0; i < ids_.length; i++) {
            lots_[i] = lot[ids_[i]];
        }
        return lots_;
    }


    function getSpecificLotHistory(string memory barcodeId_)
        internal
        view
        returns (Types.Lot memory, Types.LotHistory memory)
    {
        return (lot[barcodeId_], lotHistory[barcodeId_]);
    }

        function getSpecificLot(string memory barcodeId_)
        internal
        view
        returns (Types.Lot memory)
    {
        return (lot[barcodeId_]);
    }

    function addALot(Types.Lot memory lot_, uint256 currentTime_)
        internal 
        LotNotExists(lot_.barcodeId)
    {
        require(
            lot_.lot_user_addr == msg.sender,
            "Only user can add its own user's lot"
        );

        lots.push(lot_);
        lot[lot_.barcodeId] = lot_; //dovrebbe servire a controllare velocemente che un lotto esista (vedi LotExists)
        lotHistory[lot_.barcodeId].usershistory.push(Types.UserHistory({
            id_: msg.sender,
            date: currentTime_,
            stockdate: 0,
            action: Types.Action.added
        }));

        userLinkedLots[msg.sender].push(lot_.barcodeId);
        emit NewLot(
            lot_.id_lot,
            lot_.barcodeId,
            lot_.lot_user_addr,
            lot_.source,
            lot_.variety,
            lot_.quality, 
            lot_.temprature, 
            lot_.humidity,
            lot_.date
        );
    }




    // Modifiers

    modifier LotExists(string memory id_) {
        require(!compareStrings(lot[id_].barcodeId, ""),"lot does not exists");
        _;
    }

    modifier LotNotExists(string memory id_) {
        require(compareStrings(lot[id_].barcodeId, ""),"lot does already exists");
        _;
    }

    
    function compareStrings(string memory a, string memory b)
        internal
        pure
        returns (bool)
    {
        return (keccak256(abi.encodePacked((a))) ==
            keccak256(abi.encodePacked((b))));
    }
}

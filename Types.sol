// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.25 <0.9.0;

library Types {
    enum UserRole {
        producer, 
        device,
        database, 
        consumer, 
        buyer // può anche vendere 
        // questi sono gli utenti della blockchain
    }

    struct UserDetails {
        UserRole role;
        address id_;
        string name;
        string email;
        bool isValue;
    }

    struct Lot {
        uint256 id_lot;
        string barcodeId;
        address lot_user_addr;
        string source;
        string variety;
        string quality; 
        uint256 temprature; 
        uint256 humidity; 
        uint256 date; 
        uint256 stockdate;
    }

enum Action{
    added,
    transaction,
    update
}

    struct UserHistory {
        address id_; 
        uint256 date; 
        uint256 stockdate;
        Action action;
    }


    struct LotHistory {
        UserHistory[] usershistory;

    }
    enum TransactionType {
        ecommerce, 
        auction,
        sale
    }
    struct Transaction {
        address buyer;
        address receiver;
        string currentdate;
        uint256 price;
        TransactionType type_;
    }

}

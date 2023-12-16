// SPDX-License-Identifier: GPL-3.0
pragma experimental ABIEncoderV2;
pragma solidity >=0.4.25 <0.9.0;

import "./Types.sol";


contract Users {
    mapping(address => Types.UserDetails) internal users;

        
    constructor() {
        Types.UserDetails memory specificUser = Types.UserDetails({
            role: Types.UserRole.device,
            id_: 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4,
            name: "IoT",
            email: "IoT@example.com",
            isValue: true
        });


        users[specificUser.id_] = specificUser;
    }

    event NewUser(string name, string email, Types.UserRole role);
    event LostUser(string name, string email, Types.UserRole role);
   
   
    function addUser(Types.UserDetails memory user) public {
     require(!has(user.role, user.id_), "Stesso utente con stesso ruolo gia esistente");
        users[user.id_] = user;
        emit NewUser(user.name, user.email, user.role);
    }

    function get(address account)
        internal
        view
        returns (Types.UserDetails memory)
    {
        require(account != address(0));
        return users[account];
    }

    function has(Types.UserRole role, address account) //usato in addUser
        internal
        view
        returns (bool)
    {
        require(account != address(0));
        return (users[account].id_ != address(0) &&
            users[account].role == role); 
    }

modifier hasRole(Types.UserRole role) {
    require(msg.sender != address(0));
    require(users[msg.sender].id_ != address(0) && users[msg.sender].role == role, "Unauthorized, not a database user");
    _;
}
    
    //controlla che solo i device, producers e database possano scrivere sulla blockchain
    modifier onlyManufacturers() {
    require(
        users[msg.sender].role == Types.UserRole.device ||
        users[msg.sender].role == Types.UserRole.producer,
        "Sender is not authorized"
            );
            _;
    }

    //controlla che il sender ha un utente
    modifier userExists() {
    require(users[msg.sender].isValue, "User does not exist");
    _;
}

    //controlla che l'indirizzo ha un utente
    modifier otherUserExists(address id_) {
    require(users[id_].isValue, "User does not exist");
    _;
}
}

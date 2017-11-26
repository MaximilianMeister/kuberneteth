pragma solidity ^0.4.8;

contract mortal {
    address public owner;

    function mortal() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if (msg.sender != owner) revert();
        _;
    }

    function kill() onlyOwner {
        selfdestruct(owner);
    }
}

contract BlockCaster is mortal {
    mapping(address=>Video) public videos;

    event broadcasted(address from, string url);

    struct Video {
        string   name;
        uint8    length;
        string   url;
        uint     lastUpdate;
    }

    function broadcast(address _userAddress, string _name, uint8 _length, string _url) {
        if (_userAddress != msg.sender) revert();
        videos[_userAddress] = Video({
            name: _name,
            length: _length,
            url: _url,
            lastUpdate: now
        });
        broadcasted(_userAddress, _url);
    }
}

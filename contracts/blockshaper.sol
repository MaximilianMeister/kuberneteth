pragma solidity ^0.4.8;

contract mortal {
    address public owner;

    function mortal() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if (msg.sender != owner) throw;
        _;
    }

    function kill() onlyOwner {
        suicide(owner);
    }
}

contract Blockshaper is mortal {
    mapping(address=>Video) public videos;

    event broadcasted(address from, string url);
    
    struct Video {
        string    name;
        bool      active;
        uint8     length;
        string    webmUrl;
        uint      lastUpdate;
    }

    function broadcast(address _userAddress, string _name, bool _active, uint8 _videoLength, string _webmUrl) {
        if (_userAddress != msg.sender) throw;
        videos[_userAddress] = Video({
            name: _name,
            active: _active,
            length: _videoLength,
            webmUrl: _webmUrl,
            lastUpdate: now
        });
        broadcasted(_userAddress, _webmUrl);
    }
}

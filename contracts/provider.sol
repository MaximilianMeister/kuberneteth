contract mortal {
    address public owner;

    function mortal() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        if (msg.sender != owner) {
            throw;
        } else {
            _;
        }
    }

    function kill() onlyOwner {
        suicide(owner);
    }
}

contract User is mortal {
    string public userName;

    mapping(address=>Service) public services;

    struct Service {
        bool    active;
        uint    lastUpdate;
        uint256 debt;
    }

    function User(string _name) {
        userName = _name;
    }

    function registerToProvider(address _providerContract) onlyOwner {
        services[_providerContract] = Service({
            active: true,
            lastUpdate: now,
            debt: 0
        });
    }

    function setDebt(uint256 _debt) {
        if (services[msg.sender].active) {
            services[msg.sender].lastUpdate = now;
            services[msg.sender].debt = _debt;
        } else {
            throw;
        }
    }

    function payToProvider(address _providerContract) {
        _providerContract.send(services[_providerContract].debt);
    }

    function unsubscribeFromProvider(address _providerContract) {
        if (services[_providerContract].debt == 0) {
            services[_providerContract].active = false;
        } else {
            throw;
        }
    }
}

contract Provider is mortal {
    string public providerName;
    string public description;

    function Provider(string _name, string _description) {
        providerName = _name;
        description = _description;
    }

    function setDebt(uint256 _debt, address _userContract) {
        User person = User(_userContract);
        person.setDebt(_debt);
    }
}

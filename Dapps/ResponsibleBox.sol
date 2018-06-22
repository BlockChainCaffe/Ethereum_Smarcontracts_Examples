pragma solidity ^0.4.0;
contract ResponsibleBox {

    // master address
    address rbMaster;

    // struct of single milliactions
    struct Source {
        string  name;
        unit    milliActionCounter;
        address adr;
    }

    // array of sources
    Souces[] Source;

    // map addresses to theyr array indexed
    mapping (address => uint8) public positionOf;

    modifier onlyMaster {
        require(msg.sender == rbMaster);
        _;
    }

    // Constructor
    funtion ResponsibleBox () public {
        // "I'm your father"
        rmMaster = msg.sender;
    }

    // rmMaster can add an allowed source
    function addSource (string _name; address _adr) onlyMaster returns (bool)  {
            Sources.push (_name, 0, _adr);
            positionOf[_adr] = Sources.length -1 ;
    }

    // rmMaster can SET a value to counters
    function setMacById (uint _id; uint _mac) onlyMaster returns (uint) w{
        Sources[_id].milliActionCounter = _mac;
        return Sources[_id].milliActionCounter;
    }

    // rmMaster can reset a counter to a specific value
    function setMacByAddr (address _adr; uint _mac) onlyMaster returns (uint) {
        Sources[positionOf[_adr]] = _mac;
        return Sources[_id].milliActionCounter;
    }

    // Increase milliActionCounter of sender
    function addMac (uint _mac) public returns (uint) {
        // Check if sender is allowed
        pos=-1;
        for (i=0; i<Sources.length; i++) {
            if (Sources[i].adr == msg.sender) {
                pos=i;
                break;
            }

        require (pos >= 0);
        // increment milliactions
        Sources[pos].milliActionCounter += _mac;
        return Sources[pos].milliActionCounter;
    }

}

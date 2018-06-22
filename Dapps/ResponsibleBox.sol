pragma solidity ^0.4.0;
contract ResponsibleBox {

    // master address
    address rbMaster;

    // struct of single milliactions
    struct Scada {
        string  name;
        uint    milliActionCounter;
        address adr;
    }


    // array of sources
    Scada[] Scadas;

    // map addresses to theyr array indexed
    mapping (address => uint) public positionOf;

    modifier onlyMaster {
        require(msg.sender == rbMaster);
        _;
    }

    // Constructor
    constructor () public {
        // "I'm your father"
        rbMaster = msg.sender;
    }

    // rmMaster can add an allowed source
    function addScada (string _name, address _adr) public onlyMaster returns (bool)  {
            Scadas.push( Scada(_name, 0, _adr) );
            positionOf[_adr] = Scadas.length -1 ;
            return true;
    }

    // rmMaster can SET a value to counters
    function setMacById (uint _id, uint _mac) onlyMaster public returns (uint) {
        Scadas[_id].milliActionCounter = _mac;
        return Scadas[_id].milliActionCounter;
    }

    // rmMaster can reset a counter to a specific value
    function setMacByAddr (address _adr, uint _mac) onlyMaster public returns (uint) {
        Scadas[positionOf[_adr]].milliActionCounter = _mac;
        return Scadas[positionOf[_adr]].milliActionCounter;
    }

    // Increase milliActionCounter of sender
    function addMac (uint _mac) public returns (uint) {
        // Check if sender is allowed
        uint top = Scadas.length;
        for (uint i=0; i < top; i++) {
            if (Scadas[i].adr == msg.sender) {
                break;
            }
        }
        // exceeded end of array?
        require (i < top);
        // increment milliactions
        Scadas[i].milliActionCounter += _mac;
        return Scadas[i].milliActionCounter;
    }

}

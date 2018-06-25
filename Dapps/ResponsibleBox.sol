/**
 * Created on: 18-06-2018
 * @summary: ResponsibleBox Action counter
 * @author: Marco Crotta info@BlockchainCaffe.it
 */
pragma solidity ^0.4.0;
contract ResponsibleBox {

    // master address
    address rbMaster;

    // Arrays
    string[]  public name;
    uint[]    public milliActionCounter;

    // map addresses to theyr array indexed
    mapping (address => uint) public positionOf;

    modifier onlyMaster {
        require(msg.sender == rbMaster);
        _;
    }

    constructor () public {
        // "I'm your father"
        rbMaster = msg.sender;
    }

    function addScada (string _name, address _adr) public onlyMaster returns (uint)  {
        name.push(_name);
        milliActionCounter.push(0);
        positionOf[_adr] = name.length -1 ;
        return name.length-1;
    }

    function setMacById (uint _id, uint _mac) onlyMaster public returns (uint) {
        milliActionCounter[_id] = _mac;
        return milliActionCounter[_id];
    }

    function setMacByAddr (address _adr, uint _mac) onlyMaster public returns (uint) {
        milliActionCounter[positionOf[_adr]] = _mac;
        return milliActionCounter[positionOf[_adr]];
    }

    function addMac (uint _mac) public returns (uint) {
        milliActionCounter[positionOf[msg.sender]] += _mac;
        return milliActionCounter[positionOf[msg.sender]];
    }

}

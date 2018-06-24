/**
 * Created on: 18-06-2018
 * @summary: ResponsibleBox Action counter
 * @author: Marco Crotta info@BlockchainCaffe.it
 */
pragma solidity ^0.4.0;
/**
 * @title: ResponsibleBox
 */
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
    /**
     * @dev: just stores the owner address
     */
    constructor () public {
        // "I'm your father"
        rbMaster = msg.sender;
    }

    // rmMaster can add an allowed source
    /**
     * @dev:
     * @param string _name :  name (or ID) of the Scada device
     * @param address _adr :  address of the scada device (ethereum wallet)
     * @return : the position of the device in the Sources Array
     */
    function addScada (string _name, address _adr) public onlyMaster returns (uint)  {
            Scadas.push( Scada(_name, 0, _adr) );
            positionOf[_adr] = Scadas.length -1 ;
            return Scadas.length -1;
    }

    // rmMaster can SET a value to counters
    /**
     * @dev:
     * @param uint _id :  numeric ID of of the scada (position in the array)
     * @param uint _mac : number of milliactions to store (not add)
     * @return : the stored ammount of milliactions
     */
    function setMacById (uint _id, uint _mac) onlyMaster public returns (uint) {
        Scadas[_id].milliActionCounter = _mac;
        return Scadas[_id].milliActionCounter;
    }

    // rmMaster can reset a counter to a specific value
    /**
     * @dev:
     * @param address _adr :  address of the scada device
     * @param uint _mac :  number off milliactions to store (not add)
     * @return : the stored ammount of milliactions
     */
    function setMacByAddr (address _adr, uint _mac) onlyMaster public returns (uint) {
        Scadas[positionOf[_adr]].milliActionCounter = _mac;
        return Scadas[positionOf[_adr]].milliActionCounter;
    }

    // Increase milliActionCounter of sender
    /**
     * @dev: this function is called by individual Scadas
     * @param uint _mac :  number of milliactions to add
     * @return : number of total milliactions stored by that device
     */
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


    /**
     * @dev:
     * @return : total ammount of all milliactions stored by all scadas
     */
    function getTotalMac () public returns (uint) {
      uint top = Scadas.length;
      uint total = 0;
      for (uint i=0; i < top; i++) {
          total += Scadas[i].milliActionCounter;
      }
      return total;
    }


    function getMacById (uint _id) public retuns (uint) {
      return Scadas[_id].milliactions;
    }


    function getMacByAddr (address _adr) public returns (uint) {
      return Scadas[positionOf[_adr]].milliActionCounter;
    }
}

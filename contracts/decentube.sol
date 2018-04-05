pragma solidity ^0.4.17;
contract DCArbitration {
  function register(bytes32 _ToA, uint256 _trialDuration, string _URL)  public returns(bool);
  function fileCase(address _defendant, string _statement, string _title) public returns(uint256);
}
contract libDCourt{
    
    /*
        variables and instances
    */
    address DCAddr = address(0);
    DCArbitration DCAcontract = DCArbitration(DCAddr);
    
    /*
        Modifiers
        
    */
    
    modifier onlyDCourt(){
        require(DCAddr == msg.sender);
        _;
    }

    /*
        Functions
    */
    
    function libDCourt(bytes32 _ToA, uint256 _trialDuration, string _URL) public{
        require(DCAcontract.register(_ToA, _trialDuration, _URL));
    }
    function fileCase(address _defendant, string _statement, string _title) internal returns(uint256){
        uint256 caseID = DCAcontract.fileCase(_defendant, _statement, _title);
        require(caseID > 0);
        return caseID;
    }
    function onVerdict(uint256 _caseID, bool verdict) public;
}
contract Decentube is libDCourt{
        /*
        Enumerators
    */
    
    enum caseType{
        COPYRIGHT,
        INAPPROPRIATE
    }
    enum askType{
        INAPPROPRIATE,
        TAKEDOWN,
        TRANSFER
    }
    
    /*
        Mappings
    */
        mapping (uint256 => Case) cases;
    
    //Structs
      
    struct Case{
        address accuser;
        address defendant;
        string title;
        askType ask;
        bool decided;
        uint256 videoID;
        bool verdict;
    }
    
    struct Video {
        string magnet;
        string title;
        string description;
        uint256 date;
        uint256 tips;
        address creator;
    }

    struct Creator {
        address addr;
        string name;
        string avatar;
        string bio;
        string coinhive;
    }

    //Global variables
    uint256 count;

    //Mappings
    mapping(uint256 => Video) public videos;
    mapping(address => Creator) public creators;
    mapping(bytes32 => address) public names;
    address owner;

    uint256 uploadFee;
    //Events
    event Tip(uint256 id, uint256 value);
    event Upload(uint256 id, string magnet, address creator, string title, string description);
    event Registration(address addr, string name, string avatar, string bio, string coinhive);
    event ownershipTransfer(address from, address to, uint256 videoID);
    event takeDown(uint256 videoID, askType reason);
    event copyrightClaim(address accuser, uint256 videoID, uint256 caseID);
    event takeDownRequest(address accuser, uint256 videoID, askType reason, uint256 caseID);
    
    //Modifiers
    modifier onlyCreator(uint256 id) {
        require(msg.sender == videos[id].creator);
        _;
    }

    //Consttructor and whatnot
    function Decentube (bytes32 _ToA, uint256 _trialDuration, string _URL, uint256 _uploadFee, address _owner) libDCourt(_ToA, _trialDuration, _URL) public {
        uploadFee = _uploadFee;
        _owner = msg.sender;
    }
    //Public functions
    
    function claimVideo(address _defendant, uint256 videoID, string _statement) returns(bool){
        require(videos[videoID].creator != address(0));
        string memory _title = "Transfer of ownership of a Decentube video";
        uint256 caseID = fileCase(_defendant,  _statement, _title);
        cases[caseID].accuser = msg.sender;
        cases[caseID].defendant = _defendant;
        cases[caseID].title = _title;
        cases[caseID].videoID = videoID;
        cases[caseID].ask = askType.TRANSFER;
        emit copyrightClaim(msg.sender, videoID, caseID);
        return true;
    }
    function askForRemoval(address _defendant, uint256 videoID, string _statement, askType reason) returns(bool){
        require(videos[videoID].creator != address(0));
        require(reason == askType.INAPPROPRIATE || reason == askType.TAKEDOWN);
        bool _takedown;
        string memory _title;
        if(reason == askType.INAPPROPRIATE){
             _title = "Innappropriate content";
        }else if(reason == askType.TAKEDOWN){
            _takedown = true;
            _title = "Takedown request for copyright infringement";
        }
        
        uint256 caseID = fileCase(_defendant,  _statement, _title);
        cases[caseID].accuser = msg.sender;
        cases[caseID].defendant = _defendant;
        cases[caseID].title = _title;
        cases[caseID].videoID = videoID;
        cases[caseID].ask = reason;
        emit takeDownRequest(msg.sender, videoID, reason, caseID);
        return true;
    }
    function onVerdict(uint256 caseID, bool decision) public onlyDCourt{
        if(decision){
            if(cases[caseID].ask == askType.TRANSFER){
                emit ownershipTransfer(videos[cases[caseID].videoID].creator,cases[caseID].accuser, cases[caseID].videoID);
                videos[cases[caseID].videoID].creator = cases[caseID].accuser;
            }else if(cases[caseID].ask == askType.INAPPROPRIATE || cases[caseID].ask == askType.TAKEDOWN){
                delete videos[cases[caseID].videoID];
                emit takeDown(cases[caseID].videoID, cases[caseID].ask);
                if( cases[caseID].ask == askType.TAKEDOWN){
                    cases[caseID].accuser.transfer(uploadFee/2);
                }
            }
        }
    }
    function profile(string name, string avatar, string bio, string coinhive) public returns (bool) {
        uint256 length = utfStringLength(name);
        require(length < 16 && length > 2);
        require(names[keccak256(name)] == 0x0 || names[keccak256(name)] == msg.sender);
        names[keccak256(creators[msg.sender].name)] = 0x0;
        names[keccak256(name)] = msg.sender;
        creators[msg.sender] = Creator({addr: msg.sender, name:name, avatar:avatar, bio:bio, coinhive: coinhive});
        emit Registration(msg.sender, name, avatar, bio, coinhive);
        return true;
    }

    function create(string magnet, string title, string description) public payable returns (uint256) {
        require(msg.value == uploadFee);
        require(creators[msg.sender].addr == msg.sender);
        var length = bytes(title).length;
        require(length > 0 && length < 201);
        count += 1;
        var id = count;
        require(keccak256(videos[id].magnet) != keccak256(magnet));
        videos[id] = Video({magnet: magnet, title:title, description:description, creator: msg.sender, date:block.timestamp, tips:0});
        emit Upload(id, magnet, msg.sender, title, description);
        owner.transfer(uploadFee/2);
        return id;
    }

    function removeVideo(uint256 id) public onlyCreator(id) returns (bool) {
        delete videos[id];
        emit Upload(id, "DELETED", 0x123, "", "");
        return true;
    }

    function updateVideo(uint256 id, string title, string description) public onlyCreator(id) returns (bool) {
        var length = bytes(title).length;
        require(length > 0 && length < 201);
        Video storage thisvideo = videos[id];
        thisvideo.description = description;
        thisvideo.title = title;
        emit Upload(id, thisvideo.magnet, msg.sender, title, description);
        return true;
    }

    function tip(uint256 id) public payable returns (bool){
        Video storage thisvideo = videos[id];
        require(bytes(thisvideo.magnet).length != 0);
        thisvideo.tips += msg.value;
        emit Tip(id, msg.value);
        thisvideo.creator.transfer(msg.value);
        return true;
    }

    function utfStringLength(string str) internal pure returns (uint length) {
        uint i=0;
        bytes memory string_rep = bytes(str);

        while (i<string_rep.length)
        {
            if (string_rep[i]>>7==0)
                i+=1;
            else if (string_rep[i]>>5==0x6)
                i+=2;
            else if (string_rep[i]>>4==0xE)
                i+=3;
            else if (string_rep[i]>>3==0x1E)
                i+=4;
            else
                //For safety
                i+=1;

            length++;
        }
    }

}

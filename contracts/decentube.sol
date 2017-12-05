pragma solidity ^0.4.17;

contract Decentube {

    //Structs
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

    //Events
    event Tip(uint256 id, uint256 value);
    event Upload(uint256 id, string magnet, address creator, string title, string description);
    event Registration(address addr, string name, string avatar, string bio, string coinhive);

    //Modifiers
    modifier onlyCreator(uint256 id) {
        require(msg.sender == videos[id].creator);
        _;
    }

    //Initialization function
    function Decentube () {
        count = 0;
    }

    //Public functions
    function profile(string name, string avatar, string bio, string coinhive) public returns (bool) {
        uint256 length = utfStringLength(name);
        require(length < 16 && length > 2);
        require(names[keccak256(name)] == 0x0 || names[keccak256(name)] == msg.sender);
        names[keccak256(creators[msg.sender].name)] = 0x0;
        names[keccak256(name)] = msg.sender;
        creators[msg.sender] = Creator({addr: msg.sender, name:name, avatar:avatar, bio:bio, coinhive: coinhive});
        Registration(msg.sender, name, avatar, bio, coinhive);
        return true;
    }

    function create(string magnet, string title, string description) public returns (uint256) {
        require(creators[msg.sender].addr == msg.sender);
        var length = bytes(title).length;
        require(length > 0 && length < 201);
        count += 1;
        var id = count;
        require(keccak256(videos[id].magnet) != keccak256(magnet));
        videos[id] = Video({magnet: magnet, title:title, description:description, creator: msg.sender, date:block.timestamp, tips:0});
        Upload(id, magnet, msg.sender, title, description);
        return id;
    }

    function removeVideo(uint256 id) public onlyCreator(id) returns (bool) {
        delete videos[id];
        Upload(id, "DELETED", 0x123, "", "");
        return true;
    }

    function updateVideo(uint256 id, string title, string description) public onlyCreator(id) returns (bool) {
        var length = bytes(title).length;
        require(length > 0 && length < 201);
        Video storage thisvideo = videos[id];
        thisvideo.description = description;
        thisvideo.title = title;
        Upload(id, thisvideo.magnet, msg.sender, title, description);
        return true;
    }

    function tip(uint256 id) public payable returns (bool){
        Video storage thisvideo = videos[id];
        require(bytes(thisvideo.magnet).length != 0);
        thisvideo.tips += msg.value;
        Tip(id, msg.value);
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

//SPDX-License-Identifier: MIT
//Project-Gen
//Gen1
//STK
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "base64-sol/base64.sol";
pragma solidity ^0.8.10;
contract Gen1 is  ERC721URIStorage, ERC721Enumerable, Ownable { 
    uint256  gen_c; 
    uint256  nucleotide_m;
    uint256  gen_b;
    uint256  gen_v;
    uint256  gen_ts;
    uint256  r;
    bool     started;
    string[] nucleotide_cl;
    string[] alph_sz; 
    string[] alph_sl;                    
    constructor () ERC721 ("Project Gen","Gen-1") {
        gen_ts = 777;
        gen_v = 7 ether;   
        gen_c = 1;
        nucleotide_m = 42;
        gen_b = 274;
        nucleotide_cl = ["#00FFFF", "#00FF00", "#0000FF", "#7FFF00", "#FF1493", "#FF00FF", "#FF0000", "#FFFF00", "#FFFFFF", "#DC143C", "#DC143C"];
        alph_sz = ["b","c","d","f","g","h","i","j","j","k","l","m","n","p","q","r","s","t","v","w","x","y","z"];
        alph_sl = ["a","e","i","o","u"]; 
        r = uint256(keccak256(abi.encode(msg.sender, 777, block.timestamp)));
    }
    function generate () public payable {
        require(gen_c <= gen_ts, "Genenesis completed");
        require(msg.value >= gen_v, "insufficient funds");
        _safeMint (msg.sender , gen_c);
        string memory nucleotide_c = nucleotide_cl[(r+(nucleotide_cl.length+1)) % nucleotide_cl.length];
        string memory gen_m = gen_load(nucleotide_c) ;
        string memory gen_d = gen_init(gen_m,r,nucleotide_m);
        string memory gen_t = gen_64(gen_d);
        string memory gen_n = create_name(r);
        string memory gen_f = gen_format(gen_t,gen_n,gen_c);
        _setTokenURI(gen_c, gen_f);
        gen_c = gen_c + 1 ;
        r = uint256(keccak256(abi.encode(msg.sender, 777, block.timestamp)));  
    }
    function owned_gens(address _owner)public view returns (uint256[] memory) {
        uint256 ownerTokenCount = balanceOf(_owner);
        uint256[] memory tokenIds = new uint256[](ownerTokenCount);
        for (uint256 i; i < ownerTokenCount; i++)tokenIds[i] = tokenOfOwnerByIndex(_owner, i);
        return tokenIds;
    }
    function gen_init (string memory _gen_m, uint256 _r, uint256 _nucleotide_m) internal view returns (string memory gen_d) {
        uint256 nucleotide_m_r = uint256(keccak256(abi.encode(_r, msg.sender, 777 ))) % _nucleotide_m;
        if (nucleotide_m_r == 0)nucleotide_m_r = 42;
        for (uint i = 0; i < nucleotide_m_r; i++){
            uint256 x1 = uint256(keccak256(abi.encode(_r, i, 777 )))  % (gen_b / 2);
            uint256 y1 = uint256(keccak256(abi.encode(_r, i+1, 777 )))% (gen_b / 2);
            uint256 x2 = uint256(keccak256(abi.encode(_r, i+2, 777 )))% (gen_b / 2);
            uint256 y2 = uint256(keccak256(abi.encode(_r, i+3, 777 )))% (gen_b / 2);
            string memory gen_d1 = string(abi.encodePacked('M',c_t(x1),' ',c_t(y1),' ',c_t(x2),' ',c_t(y2),'Z'));
            string memory gen_d2 = string(abi.encodePacked('M',c_t(gen_b-x1),' ',c_t(y1),' ',c_t(gen_b-x2),' ',c_t(y2),'Z'));
            string memory gen_d3 = string(abi.encodePacked('M',c_t(gen_b-x1),' ',c_t(gen_b-y1),' ',c_t(gen_b-x2),' ',c_t(gen_b-y2),'Z'));
            string memory gen_d4 = string(abi.encodePacked('M',c_t(x1),' ',c_t(gen_b-y1),' ',c_t(x2),' ',c_t(gen_b-y2),'Z'));
            gen_d = string(abi.encodePacked(gen_d,gen_d1,gen_d2,gen_d3,gen_d4)); 
        }
        gen_d = string(abi.encodePacked(_gen_m,gen_d,'" /></svg>'));
    }
    function gen_64(string memory gen_d) internal pure returns (string memory) {
        string memory base = "data:image/svg+xml;base64,";
        string memory _gen_64 = Base64.encode(bytes(string(abi.encodePacked(gen_d))));
        return string(abi.encodePacked(base,_gen_64));
    }
    function gen_format(string  memory _gen_t, string memory _gen_name, uint256 _gen_c) internal pure returns (string memory) {
        string memory base = "data:application/json;base64,";
        return string(abi.encodePacked(base,Base64.encode(bytes(abi.encodePacked('{"name": "', _gen_name,'", ','"description": "Gen1 N0:',c_t(_gen_c),'", ','"attributes": "", ','"image": "', _gen_t,'"}')))));
    }    
    function gen_load (string memory _nucleotide_c) internal pure returns (string memory gen_m6) {
        string memory gen_m1 = data_m1();
        string memory gen_m2 = data_m2(gen_m1);
        string memory gen_m3 = data_m3(gen_m2,_nucleotide_c);
        string memory gen_m4 = data_m4(gen_m3,_nucleotide_c);
        string memory gen_m5 = data_m5(gen_m4);
        gen_m6 = data_m6(gen_m5);
    }
    function data_m1 () internal pure returns (string memory _data_m1) {
        _data_m1 = string(abi.encodePacked('<svg version="1.1" xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" viewBox="0 0 274 274" enable-background="new 0 0 274 274" xml:space="preserve" style="background-color:black">','\n'));
    }
    function data_m2 (string memory _data_m1) internal pure returns (string memory _data_m2) {
         _data_m2 = string(abi.encodePacked('<style>','\n','.svg1 {','\n','stroke-dasharray: 200;','\n','stroke-dashoffset: 822;','\n','animation: dash 15s infinite ;','\n','}','\n'));
         _data_m2 = string(abi.encodePacked(_data_m1,_data_m2));
    }  
    function data_m3 (string memory _data_m2, string memory _nucleotide_c) internal pure returns (string memory _data_m3) {
         _data_m3 = string(abi.encodePacked('@keyframes dash {','\n','from {','\n','stroke-dashoffset: 822;','\n','stroke: ',_nucleotide_c,';','\n','}','\n')); 
         _data_m3 = string(abi.encodePacked(_data_m2,_data_m3));    
    }
    function data_m4 (string memory _data_m3, string memory _nucleotide_c) internal pure returns (string memory _data_m4) {
         _data_m4 = string(abi.encodePacked('to {','\n','stroke-dasharray: 411;','\n','stroke: ',_nucleotide_c,';','\n','}','\n','}','\n','</style>')); 
         _data_m4 = string(abi.encodePacked(_data_m3,_data_m4));    
    }
    function data_m5 (string memory _data_m4) internal pure returns (string memory _data_m5) {
         _data_m5 = string(abi.encodePacked('<defs><filter id="f1"><feConvolveMatrix kernelMatrix="1 1 0 0 0 0 0 1 -1"/></filter></defs>')); 
         _data_m5 = string(abi.encodePacked(_data_m4,_data_m5));    
    }
    function data_m6 (string memory _data_m5) internal pure returns (string memory _data_m6) {
         _data_m6 = string(abi.encodePacked('<path class="svg1" filter="url(#f1)" style="fill: none; stroke: white; stroke-width: 0.3; stroke-linecap: round; stroke-linejoin:  miter; stroke-miterlimit: 1;" d="')); 
         _data_m6 = string(abi.encodePacked(_data_m5,_data_m6));    
    }
    function create_name(uint256 _r) public view returns (string memory gen_name)  {
        uint256 n1 = uint256(keccak256(abi.encode(msg.sender, _r+gen_c, 777 )))     % 666;
        uint256 n2 = uint256(keccak256(abi.encode(msg.sender, _r+(gen_c+5), 777 ))) % 555;
        uint256 n3 = uint256(keccak256(abi.encode(msg.sender, _r+(gen_c+4), 777 ))) % 444;
        uint256 n4 = uint256(keccak256(abi.encode(msg.sender, _r+(gen_c+3), 777 ))) % 333;
        uint256 n5 = uint256(keccak256(abi.encode(msg.sender, _r+(gen_c+2), 777 ))) % 222;
        uint256 n6 = uint256(keccak256(abi.encode(msg.sender, _r+(gen_c+1), 777 ))) % 111;
        if (n1 < 333){ 
            gen_name = string(abi.encodePacked(alph_sl[(n1+(alph_sl.length+1)) % alph_sl.length]));
            gen_name = string(abi.encodePacked(gen_name,alph_sz[(n2+(alph_sz.length+1)) % alph_sz.length]));
            if (n2 > 252){
                gen_name = string(abi.encodePacked(gen_name,alph_sz[(n3+(alph_sz.length+1)) % alph_sz.length]));
                gen_name = string(abi.encodePacked(gen_name,alph_sl[(n4+(alph_sl.length+1)) % alph_sl.length]));
                gen_name = string(abi.encodePacked(gen_name,alph_sz[(n5+(alph_sz.length+1)) % alph_sz.length]));
                gen_name = string(abi.encodePacked(gen_name,alph_sl[(n6+(alph_sl.length+1)) % alph_sl.length]));
            }else{
                gen_name = string(abi.encodePacked(gen_name,alph_sl[(n3+(alph_sl.length+1)) % alph_sl.length]));
                gen_name = string(abi.encodePacked(gen_name,alph_sz[(n4+(alph_sz.length+1)) % alph_sz.length]));           
                if(n3 > 222){
                    gen_name = string(abi.encodePacked(gen_name,alph_sl[(n5+(alph_sl.length+1)) % alph_sl.length]));
                    gen_name = string(abi.encodePacked(gen_name,alph_sz[(n6+(alph_sz.length+1)) % alph_sz.length]));
                }else{
                    gen_name = string(abi.encodePacked(gen_name,alph_sz[(n5+(alph_sz.length+1)) % alph_sz.length]));
                    gen_name = string(abi.encodePacked(gen_name,alph_sl[(n6+(alph_sl.length+1)) % alph_sl.length]));
                }
            }    
        }else{
            gen_name = string(abi.encodePacked(gen_name,alph_sz[(n1+(alph_sz.length+1)) % alph_sz.length]));
            gen_name = string(abi.encodePacked(gen_name,alph_sl[(n2+(alph_sl.length+1)) % alph_sl.length]));
            if (n3 > 222){
                gen_name = string(abi.encodePacked(gen_name,alph_sz[(n3+(alph_sz.length+1)) % alph_sz.length]));
                gen_name = string(abi.encodePacked(gen_name,alph_sl[(n4+(alph_sl.length+1)) % alph_sl.length]));
                gen_name = string(abi.encodePacked(gen_name,alph_sz[(n5+(alph_sz.length+1)) % alph_sz.length]));
                gen_name = string(abi.encodePacked(gen_name,alph_sl[(n6+(alph_sl.length+1)) % alph_sl.length]));
            }else{
                gen_name = string(abi.encodePacked(gen_name,alph_sz[(n3+(alph_sz.length+1)) % alph_sz.length]));     
                if(n4 > 111){
                    gen_name = string(abi.encodePacked(gen_name,alph_sz[(n4+(alph_sz.length+1)) % alph_sz.length]));
                    gen_name = string(abi.encodePacked(gen_name,alph_sl[(n5+(alph_sl.length+1)) % alph_sl.length]));
                    gen_name = string(abi.encodePacked(gen_name,alph_sz[(n6+(alph_sz.length+1)) % alph_sz.length]));
                }else{
                    gen_name = string(abi.encodePacked(gen_name,alph_sz[(n4+(alph_sz.length+1)) % alph_sz.length]));
                    gen_name = string(abi.encodePacked(gen_name,alph_sl[(n5+(alph_sl.length+1)) % alph_sl.length]));
                    gen_name = string(abi.encodePacked(gen_name,alph_sz[(n6+(alph_sz.length+1)) % alph_sz.length]));
                }
            }
        }
    }
    function c_t(uint _nucleotide_c_c) internal pure returns (string memory ) {
        if (_nucleotide_c_c == 0) {return "0";}
        uint _nucleotide_c_c_c = _nucleotide_c_c;
        uint _nucleotide_c_c_l;
        while (_nucleotide_c_c_c != 0) {_nucleotide_c_c_l++;_nucleotide_c_c_c /= 10;}
        bytes memory _nucleotide_c_t_s = new bytes(_nucleotide_c_c_l);
        uint _nucleotide_c_c_l_c = _nucleotide_c_c_l;
        while (_nucleotide_c_c != 0) {
            _nucleotide_c_c_l_c = _nucleotide_c_c_l_c-1;
            uint8 _nucleotide_c_t = (48 + uint8(_nucleotide_c_c - _nucleotide_c_c / 10 * 10));
            bytes1 _nucleotide_c_b = bytes1(_nucleotide_c_t);
            _nucleotide_c_t_s[_nucleotide_c_c_l_c] = _nucleotide_c_b;
            _nucleotide_c_c /= 10;
        }
        return string(_nucleotide_c_t_s);
    }
    function harvest() public payable onlyOwner {
        (bool success, ) = payable(msg.sender).call{value: address(this).balance}("");
        require(success);
    }
    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
    }
    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }
    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }
    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
}
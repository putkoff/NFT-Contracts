// SPDX-License-Identifier: MIT
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}
abstract contract Ownable is Context {
    address private _owner;
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    
    constructor() {
        _transferOwnership(_msgSender());
    }
    function owner() public view virtual returns (address) {
        return _owner;
    }
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }
    
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}
pragma solidity ^0.8.0;
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}
library Address {
    function isContract(address account) internal view returns (bool) {
        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }
    
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }
    
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }
    
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }
    
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }
    
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");
        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }
    
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }
    
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");
        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }
    
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }
    
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");
        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }
    
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            if (returndata.length > 0) {
                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}
pragma solidity ^0.8.0;
library SafeERC20 {
    using Address for address;
    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }
    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }
    
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }
    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }
    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }
    
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}
pragma solidity ^0.8.0;
interface IERC20Metadata is IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}
pragma solidity ^0.8.0;
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;
    string private _name;
    string private _symbol;
    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }
    function name() public view virtual override returns (string memory) {
        return _name;
    }
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);
        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        unchecked {
            _approve(sender, _msgSender(), currentAllowance - amount);
        }
        return true;
    }
    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");
        _beforeTokenTransfer(sender, recipient, amount);
        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[sender] = senderBalance - amount;
        }
        _balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
        _afterTokenTransfer(sender, recipient, amount);
    }
    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}
abstract contract prevNebulaNftMint is Context {
	function NFTAccountsLength() external virtual returns(uint256);
	function NFTAccountAddress(uint256 _x) external virtual returns(address);
	function NFTaccountExists(address _account) external virtual returns (bool);
	function NFTaccountData(address _account) external virtual returns(uint256,uint256,uint256,uint256,uint256,uint256,uint256,bool);
}
abstract contract overseer is Context {
   function getFee() external view returns(uint256);
   function getCustomPrice(uint256 _price) external view returns(uint256);
} 
contract PutFiNftMint is Ownable {
    struct TOTALS {
    	    uint256 tier_1;
    	    uint256 tier_2;
    	    uint256 tier_3;
    	    uint256 total;
    	    uint256 totalUSD;
    	    uint256 totalAVAX;
    	    bool full;
    	   }
    mapping(address => TOTALS) public totals;
    address[] public NFTaccounts;
    address[] public NFTtransfered;
    address public nftAddress;
    address public _overseer;
    address Guard;
    uint256 public limit;
    uint256[] public maxSupplies;
    uint256[] public nft_cost;
    overseer public over;
    NebulaNFT public nft;
    constructor(address[] memory addresses,uint256[] memory supplies,uint256[] memory _costs,uint256 _limit) {
    	for(uint i = 0;i<addresses.length;i++){
    		require(addresses[i] != address(0) && addresses[i] != address(this),"your constructor addresses contain either burn or this");
    	}
    	nftAddress = addresses[0];
    	nft = NebulaNFT(nftAddress);
    	_overseer = addresses[1];
    	over = overseer(_overseer);
    	for(uint i=0;i<_costs.length;i++){
    		nft_cost.push(_costs[i]*(10**18));
    	}
    	for(uint i=0;i<_costs.length;i++){
    		maxSupplies.push(supplies[i]);
    	}
    	limit = _limit;
    	
    }
    function getMax(uint256 _num) internal pure returns(bool){
        TOTALS storage house = totals[address(this)];
        if(_num == 0){
    		if(house.tier_1 < maxSupplies[_num]){
    			return false;
    		}
    	}
    	if(_num == 1){
    		if(house.tier_2 < maxSupplies[_num]){
    			return false;
    		}
    	}
    	if(_num == 2){
    		if(house.tier_3 < maxSupplies[_num]){
    			return false;
    		}
    	}
    	return true;
    }
    function mint(uint256 _id) payable external {
    	uint256 num = _id - 1;
    	require(getMax(num) == false,"the totala supply for this tier has already been minted");
    	address _account = msg.sender;
    	uint256 _price = over.getCustomPrice(nft_cost[num]);
    	uint256 _value = msg.value;
    	require(_value >= _price,"you did not send enough to purchase this NFT");
    	uint256 balance = nebuLib.mainBalanceOf(_account);
    	require(balance >= _value,"you do not hold enough to purchase this NFT");
        if (nebuLib.isInList(_account,NFTaccounts) == false){
    		NFTaccounts.push(_account);
    	}
    	
    	require(tot.full != true,"sorry, you already have too many NFT's");
    	if (_id == 1){
	    nft.Pmint(_account,1,1,"0x0");
    	}else if (_id == 2){
	    nft.Pmint(_account,2,1,"0x0");
    	}else if (_id == 3){
	    nft.Pmint(_account,3,1,"0x0");
    	}
    	treasury.transfer(_price);
    	uint256 returnBalance = _value.sub(_price);
    	if(returnBalance > 0){
		payable(_account).transfer(returnBalance);
	}
	updateTotals(_account,_id,1,_price);
    }
    function MGRmint(uint256[] memory _ids,address[] memory _accounts,bool[] _sends,bool[] _records,bool[] _fullOverrrides) external onlyManager(msg.sender) {
    	for(uint i=0;i<_ids.length;i++){
    		uint256 _id = _ids[i];
    		address _account = _accounts[i];
	    	uint256 num = _id - 1;
	    	bool _send = sends[i];
	    	bool _record = _records[i];
	    	TOTALS storage tot = totals[_account];
	    	bool full = tot.full;
	    	if(_fullOverrrides[i] == true){
	    		full = false
	    	}
		if (nebuLib.isInList(_account,NFTaccounts) == false){
	    		NFTaccounts.push(_account);
	    	}
	    	if (full == false && _send[i] == true) {
		    	checkFull(num);
		    	if (_id == 1){
			    nft.Pmint(_account,1,1,"0x0");
		    	}else if (_id == 2){
			    nft.Pmint(_account,2,1,"0x0");
		    	}else if (_id == 3){
			    nft.Pmint(_account,3,1,"0x0");
		    	}
		}
		if (_record == true){
		    	updateTotals(_account,_id,1,);
		}
		
	    }
    }
    function transferAllNFTdata(address prev) external onlyManager(msg.sender) {
    		prevNFTpayable _prev = prevNFTpayable(prev);
    	    	uint256 accts = _prev.NFTAccountsLength();
    	    	for(uint i=0;i<accts;i++){
    	    		address _account = _prev.NFTAccountAddress(i);
    	    		if(nebuLib.isInList(_account,PROTOtransfered) == false){
	    	    		TOTALS storage tots = totals[_account];
	    	    		(uint256 a,uint256 b,uint256 c,uint256 d,uint256 e,uint256 f,uint256 g,bool h)= _prev.NFTaccountData(_account);
	    	    		tots.tier_1 = a;
	    	    		tots.tier_2 = b;
	    	    		tots.tier_3 = c;
	    	    		tots.total =d;
	    	    		tots.totalUSD = e;
	    	    		tots.totalAVAX = f;
	    	    		tots.totalfees = g;
	    	    		tots.full = h;
	    			NFTtransfered.push(_account);
	    		}
	    	}
    }
    function updateTotals(address _account, uint256 _id,uint256 _amount) internal {
    	uint256[3] memory vals = [Zero,Zero,Zero];
    	if(_id != 0){
    		vals[_id-1] = _id;
    	}
    	TOTALS storage tot = totals[_account];
    	tot.tier_1 += vals[0];
    	tot.tier_2 += vals[1];
    	tot.tier_3 += vals[2];
    	if(_id != 0){
        	tot.total += 1;
        }
    	tot.totalUSD += _amount;
    	tot.totalAVAX += msg.value;
	tot.full = false;
	if (fees !=false){
		queryFees(_account);
	}
    	if ((tot.tier_1).add(tot.tier_2).add(tot.tier_3) >= 10){
    		tot.full = true;
    	}
    }
    function changeCostNfts(uint256[3] memory _costs) external onlyOwner{
        nft_cost.length = 0;
    	for(uint i = 0;i<_costs.length;i++){
    		nft_cost.push(_costs[i]*(10**18));
    	}
    }
    function NFTaccountExists(address _account) external returns (bool) {
    	return isInList(_account,NFTaccounts);
    }
    function nftAccountData(address _account) external onlyManager(msg.sender) returns(uint256,uint256,uint256,uint256,uint256,uint256,uint256,bool){
    		TOTALS storage tot = totals[_account];
    		return (tot.tier_1,tot.tier_2,tot.tier_3,tot.total,tot.totalUSD,tot.totalAVAX,tot.totalfees,tot.full);
    	}
    function changeNFTAddress(address _address) external onlyManager(msg.sender) {
    	nftAddress = _address;
    	nft = NebulaNFT(nftAddress);
    }
    function updateManagers(address newVal) external onlyOwner {
    	if(isInList(newVal,Managers) ==false){
        	Managers.push(newVal); //token swap address
        }
    }
    function updateGuard(address _address) external onlyOwner {
        Guard = _address; //token swap address
    }
    function changeGracePeriod(uint256 _days) external onlyOwner {
    	gracePeriod = _days * 1 days;
    }
    function nftAccountsLength() external view returns(uint256){
    	return NFTaccounts.length;
    }
    function nftAddress(uint256 _x) external view returns(address){
    	return NFTaccounts[_x];
    }
    function nftAccountExists(address _account) external returns (bool) {
    	return isInList(_account,NFTaccounts);
    }
    function transferOut(address payable _to,uint256 _amount) payable external  onlyOwner(){
		_to.transfer(_amount);
    }
    function transferAllOut(address payable _to,uint256 _amount) payable external onlyOwner(){
		_to.transfer(address(this).balance);
    }
    function sendAllTokenOut(address payable _to,address _token) external onlyOwner(){
		IERC20 newtok = IERC20(_token);
		feeTok.transferFrom(address(this), _to, feeTok.balanceOf(address(this)));
    }
}

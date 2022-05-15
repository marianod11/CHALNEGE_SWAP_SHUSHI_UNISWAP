// SPDX-License-Identifier: MIT


pragma solidity ^0.8.0;

import './interfaces/MasterChef.sol';
import './interfaces/IUniswapV2Router02.sol';
import './interfaces/IUniswapV2Pair.sol';
import './interfaces/IUniswapV2Factory.sol';

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint value);
    event Transfer(address indexed from, address indexed to, uint value);

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint);
    function balanceOf(address owner) external view returns (uint);
    function allowance(address owner, address spender) external view returns (uint);

    function approve(address spender, uint value) external returns (bool);
    function transfer(address to, uint value) external returns (bool);
    function transferFrom(address from, address to, uint value) external returns (bool);
}

contract SushiSwapChallenge {


  MasterChef public  masterChef;
  IUniswapV2Router02 immutable  sushiRouter;


  IUniswapV2Factory public factory;
  address public sushi;
  address public dai;
  uint256 public deadline = 356 days; 
  

  event Log(string message, uint value);

  constructor(IUniswapV2Router02 _sushiRouter, address _sushi, address _dai, IUniswapV2Factory _factory)  {
    sushiRouter = _sushiRouter;
    sushi = _sushi;
    dai = _dai;
    factory = _factory;
  }



  function sushiSwap(uint _amountA, uint _amountB,uint _amountAMin, uint _amountBMin,  uint _pid) public { 
      require(_amountA != 0 && _amountB != 0, "NO PUEDE SER ZEROOOOOOOO"); 

      //TRANSFER TOKEN AL CONTRATO
      IERC20(sushi).transferFrom(msg.sender, address(this), _amountA);
      IERC20(dai).transferFrom(msg.sender, address(this), _amountB);


      //APPROVE
      IERC20(sushi).approve(address(sushiRouter), _amountA);
      IERC20(dai).approve(address(sushiRouter), _amountB);


      //agregar liquidez y obtener token slp

      (uint amountA, uint amountB, uint liquidity ) =
      IUniswapV2Router02(sushiRouter)
      .addLiquidity(
        sushi,
        dai,
        _amountA,
        _amountB,
        _amountAMin, 
        _amountBMin,
        address(this),
        deadline  
      );


      emit Log("CANTIDAD SUSHII", amountA);
      emit Log("CANTIDAD DAII", amountB);
      emit Log("LIQUIDESS", liquidity);


      address pair = IUniswapV2Factory(factory).getPair(sushi, dai);
      require(pair != address(0), "pool no existe!!");
      
      require(liquidity != 0, "NO PUEDE SER ZEROOOOOOOO"); 

      IUniswapV2Pair(pair).approve(address(masterChef), liquidity);

       if(liquidity > 0){
         masterChef.deposit(_pid, liquidity);
      }
  
  }


  
}
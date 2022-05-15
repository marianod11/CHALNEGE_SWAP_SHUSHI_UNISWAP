const SushiSwapChallenge = artifacts.require("./SushiSwapChallenge.sol")


contract ("SushiSwapChallenge", async()=>{

        let sushiChallenge;
        let amountA = 1000;
        let amountB = 1000;
        let amountAMin = amountA * 80/ 100 ;
        let amountBMin = amountB * 80/ 100 ;

    before(async()=>{
    
        sushiChallenge = await SushiSwapChallenge.deployed("0xd9e1ce17f2641f24ae83637ab66a2cca9c378b9f",
        "0x6b3595068778dd592e39a122f4f5a5cf09c90fe2",
        "0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2",
         " 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f")
    })

    
    describe("deployed", async()=>{
        it("workk", async()=>{

            const sushiPool = await sushiChallenge.sushiSwap(amountA,amountB,amountAMin,amountBMin,1);
            console.log("CHALENGEEE",sushiPool)

        })
       



    })
})
pragma solidity ^0.4.0;

contract shopping_mall{//contract for a shopping mall
    address public owner;//saves the address of the owner of the mall
    struct shopper{//defining a new datatype, a shopper
        uint amount;//amount left with the shopper which he can spend
        product[] items;//items the shooper has  brought
        address id;
    }
    struct product{ // datatype defining the product available in the mall
        uint cost;//cost of the product
        bytes32 name;
        uint quantity;//quantity of the product left
    }
    product[] public products;
    mapping (address => shopper) public shoppers;//hashmap storing the address of the shoppers
    function shopping_mall(uint[] prices , bytes32[] names , uint[] quan) public {//constructing a mall
        owner = msg.sender;
        shoppers[owner].amount  = 1000000;//setting owners account
        for ( uint i=0 ; i < prices.length ; i++ ){
            products.push(product({cost : prices[i] , name: names[i],quantity : quan[i] }));//adding products in the mall
        }
    }
    
    shopper[] public shoppers_1;
    
    
    
    function add_shopper(address _shopper) public returns (address){//adding a new shopper
       // require(msg.sender == owner);//checking that the person adding is the chairman
        shoppers[_shopper].amount = 10000;
        shoppers[_shopper].id = _shopper;//giving initial amount
        shoppers_1.push(shoppers[_shopper]);
        return msg.sender;
    }
    
    function add_product(bytes32 n, uint c , uint q){//adding a new product to the mall
        for(uint i=0; i < products.length ; i++){//checking if the product already exists
            if ((n == products[i].name) && (c == products[i].cost)){
                products[i].quantity  =  q + products[i].quantity;//if yes, then increasing its quantity
                return;
            }
           
        }
        products.push(product({cost : c , name : n , quantity : q}));//if no , the adding the new product
    }
    
    function buy_product(address x ,bytes32 n) returns (uint){
        shopper storage shop ;
        for (uint j=0;j<shoppers_1.length;j++){
            if (x == shoppers_1[j].id){
                shop = shoppers_1[j];
            }
        }
        for (uint i=0; i<products.length; i++){//checking if such a product is there or not. 
            if (n == products[i].name){
                if (shop.amount >= products[i].cost){
                    shop.items.push(products[i]);
                    products[i].quantity--;
                    shop.amount = shop.amount - products[i].cost;
                    return shop.amount;
                }
                else{
                    throw;
                    //console.log("Not enough money");
                }
            }
            
        }
        
    }
    
    function checkamt(address x) returns (uint){
        return shoppers[x].amount;
    }
    
    
}

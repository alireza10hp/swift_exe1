
struct Name {
    var fullName : String = "";
    var crypto : [Crypto] = [];
    
}

struct Crypto {
    var name : String = "";
    var price : Double = 0.0;
    var price_date : String = "" ;/*change with struct*/
    
}



print("Hello World  \n  choose a number : \n 1.Profile \n 2.cryptocurrency \n 3.exit")
let str = readLine() 



switch (str){
    
    case  "1" :
        print ("profile")
    case  "2" :
        print ("cryptocurrency")
    case  "3" :
        print("good bye !")
        break
    default :
        print ("please enter correct number !")
}

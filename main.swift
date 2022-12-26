struct User {
    var name : String = "user";
    var crypto : [Crypto] = [];
    
}

struct Crypto {
    var name : String = "";
    var price : Double = 0.0;
    var price_date : String = "" ;/*change with struct*/
    
}

var user = User()
print("Hello !\n " )
var exit = false
while (!exit){

    print("Choose a number :\n 1.Profile\n 2.Cryptocurrency\n 3.Exit\n")
    var str = readLine() 

    switch (str){
        
        case  "1" :
            var back = false
            while(!back){
                print ("Profile:\n")
                print ("username :\(user.name) ")
                print("Choose a number :\n 1.Change profile name\n 2.Back\n")
                str = readLine() 
                switch str {
                    case  "1" :
                        print ("Change profile name :\n please enter new profile name ")
                        str = readLine()
                        user.name = str!
                        print ("your profile name changed ! ")
                    case  "2" :
                        back = true
                    default :
                        print ("Please enter correct number !")
                        
                    
                } 
            }
        case  "2" :
            print ("Cryptocurrency")
        case  "3" :
            print("Good bye !")
            exit = true
            
        default :
            print ("Please enter correct number !")
    }
}

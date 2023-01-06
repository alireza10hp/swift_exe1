import Foundation


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
                    case "1" :
                        print ("Change profile name :\n please enter new profile name ")
                        str = readLine()
                        user.name = str!
                        print ("your profile name changed ! ")
                    case "2" :
                        back = true
                    default :
                        print ("Please enter correct number !")
                        
                } 
            }
        case  "2" :
           
            var back = false
            while(!back){
                print ("Cryptocurrency")
                print("Choose a number :\n 1.Show all Cryptocurrency\n 2.Add Cryptocurrency\n 3.Delete Cryptocurrency\n 4.Back\n")
                str = readLine() 
                
				//use twelvedata
				
				

				let request = NSMutableURLRequest(url: NSURL(string: "https://api.twelvedata.com/time_series?apikey=367baabfd4ca48d7b29801a4d41962d0&interval=5min&symbol=AAX&country=United State,Us&exchange=ACX&outputsize=12&dp=4&start_date=2023-01-01 11:21:00&end_date=2023-01-06 11:21:00&format=CSV")! as URL,
														cachePolicy: .useProtocolCachePolicy,
													timeoutInterval: 10.0)
				request.httpMethod = "GET"

				let session = URLSession.shared
				let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
					if (error != nil) {
						print(error)
					} else {
						let httpResponse = response as? HTTPURLResponse
						print(httpResponse)
					}
				})

				dataTask.resume()    
    
                 
                switch str {
                    case "1" :
                        print( "show all crypto")
                        
                    case "2" :
                        print ("Add Cryptocurrency ")
                    case "3" :
                        print ("Delete Cryptocurrency")
                    case "4" :
                        back = true
                    default :
                        print ("Please enter correct number !")
                        
                    
                } 
            
            }
            
        case  "3" :
            print("Good bye !")
            exit = true
            
        default :
            print ("Please enter correct number !")
    }
}

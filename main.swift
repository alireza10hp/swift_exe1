import Foundation
import Glibc


struct User {
    var name : String = "user";
    var crypto : [Crypto] = [];
    
}

struct Crypto {
    var symbol : String;
    var currency_base : String;
    var currency_quote : String;
    var exchange :String ;
    var type : String ;
    var values : [Values];
}

struct Values {
    var datetime : String;
    var open : Double;
    var high : Double;
    var low : Double;
    var close : Double;
}

var cryptoList = ["BTC", "ETH"]
var all = ["AAC","ACX","BTC","ETH","USDC","USDC","BNB"]
var price = ["test" : [String : Int]()]
let dateFormatterGet = DateFormatter()
dateFormatterGet.dateFormat = "yyyy-MM-dd"  

for c in all {
    let strDate = "2022-12-1"
    var date = dateFormatterGet.date(from: strDate)!
    var datePrice = [String : Int]()
    
    for _ in 1...30 {
        datePrice[dateFormatterGet.string(from: date)] = Int.random(in: 100..<10000)
        date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    }
    
    price[c] = datePrice
}


func showcoins(coin : String){
    print("\nYou have selected \(coin).\ninput format : (yyyy-MM-dd)")
    print("start:")
    let startDate = readLine()!
    print("end:")
    let endDate = readLine()!
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"    
    
    if dateFormatterGet.date(from: startDate) != nil && dateFormatterGet.date(from: endDate) != nil && endDate >= startDate {
        var start = dateFormatterGet.date(from: startDate)!
        let end = dateFormatterGet.date(from: endDate)!

        let diff = Calendar.current.dateComponents([.day], from: start, to: end).day! + 1
        print("\nprices:")
        for _ in 1...diff{
            
            print("date: "+dateFormatterGet.string(from: start) + "        Price: \(price[coin]![dateFormatterGet.string(from: start)]!)")
            start = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        }
  
    } else if endDate < startDate {
        print("\nError:start > end!")
    } else {
        print("\nError:invalid dates!")
    }   
    
}


//load from json 

var user = User()
print("Hello !\n " )
var exit = false
while (!exit){

    print("Choose a number :\n 1.Profile\n 2.Cryptocurrency\n 3.Exit\n")
    var str = readLine() 
    system("clear")

    switch (str){
        
        case  "1" :
            var back = false
            while(!back){
                print ("Profile:\n")
                print ("username :\(user.name) \n")
                print("Choose a number :\n1.Change profile name\n2.Back\n")
                str = readLine() 
                system("clear")
                switch str {
                    case "1" :
                        print ("Change profile name :\nplease enter new profile name ")
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
                print("Choose a number :\n1.Show all Cryptocurrency\n2.Add Cryptocurrency\n3.Delete Cryptocurrency\n4.Back\n")
                str = readLine() 
                system("clear")
                
				//use twelvedata
				
				
                /*
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
                */
                 
                switch str {
                    case "1" :
                        print( "show all crypto")
                        print("\nCrypto :")
                        print("List of your cryptocurrencies : ( detail with name)")
                    
                        
                        for (i, coin) in cryptoList.enumerated(){
                            print("\(i+1).\(coin)")
                        }
                        
                        print("Choose a number :\n1.Show all Cryptocurrency\n2.Add Cryptocurrency\n3.Delete Cryptocurrency\n4.Back\n")
                        
                        let str = readLine()
                        for (i, coin) in cryptoList.enumerated(){
                            if str == cryptoList[i]{
                                showcoins(coin : coin)
                            }
                        }
                    case "2" :
                        print ("Add Cryptocurrency ")
                        print("\nAdd : with name.")
                      
                        var count = 0
                        for coin in all {
                            if !cryptoList.contains(coin){
                                count += 1
                                print("\(count).\(coin)")
                            }
                        }
                        
                        let str = readLine()!
                        if all.contains(str){
                            cryptoList.append(str)
                            print("\(str) added to your list.")
                            
                        }
    
                        
                    case "3" :
                        print ("Delete Cryptocurrency")
                        print("\nDelete: with name.")
                        for (i, coin) in cryptoList.enumerated(){
                            print("\(i+1).\(coin)")
                        }
                        let str = readLine()!
                        
                        for (i, _) in cryptoList.enumerated(){
                            if str == cryptoList[i]{
                                if let index = cryptoList.firstIndex(of: str) {
                                    cryptoList.remove(at: index)
                                }
                                print("\(str) Deleted from your list.")
                                
                            }
                        }
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



import Foundation
// import Glibc


struct User {
    var name : String = "default";
    var crypto : [Crypto] = [];
    var coins : [String] = [];
    
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

struct FileData: Decodable {
    var crypto: [Coin];
    init() {
        crypto = []
    }
}

struct Coin: Decodable {
    var meta : Meta;
    var values : [Value];
}

struct Meta: Decodable {
    var symbol : String;
    var interval : String;
    var currency : String;
    var exchange_timezone : String;
    var exchange :String ;
    var mic_code : String;
    var type : String ;
}

struct Value: Decodable {
    var datetime : String;
    var open : String;
    var high : String;
    var low : String;
    var close : String;
}

// default user
var user = User()

// main data loaded from json
var mainData: FileData = FileData()
// read json file
if let path = Bundle.main.path(forResource: "new_data", ofType: "json"){
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let decoder = JSONDecoder()
        let jsonData = try decoder.decode(FileData.self, from: data)
        mainData = jsonData
    } catch {
        print("error:", error)
    }
}

// var cryptoList = ["BTC", "ETH"]
// var all = ["AAC","ACX","BTC","ETH","USDC","USDC","BNB"]
// var price = ["test" : [String : Int]()]
// let dateFormatterGet = DateFormatter()
// dateFormatterGet.dateFormat = "yyyy-MM-dd"  

// serialized data from mainData
var cryptoDict : [String: [Value]] = [:]

// serialize data
for (i, element) in mainData.crypto.enumerated() {
  cryptoDict[element.meta.symbol] = element.values
  // add default coins to user's
  if i < 3 {
      user.coins.append(element.meta.symbol)
  }
}

// for c in all {
//     let strDate = "2022-12-1"
//     var date = dateFormatterGet.date(from: strDate)!
//     var datePrice = [String : Int]()
    
//     for _ in 1...30 {
//         datePrice[dateFormatterGet.string(from: date)] = Int.random(in: 100..<10000)
//         date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
//     }
    
//     price[c] = datePrice
// }


func showcoin(coin : String){
    while true {
        print("\nYou have selected \(coin).\ninput format : (yyyy-MM-dd)")
        print("start:")
        let startDate = readLine()!
        print("end:")
        let endDate = readLine()!
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"    
        
        if dateFormatterGet.date(from: startDate) != nil && dateFormatterGet.date(from: endDate) != nil{
            var start = dateFormatterGet.date(from: startDate)!
            let end = dateFormatterGet.date(from: endDate)!

            if start > end {
                system("clear")
                print("ERROR: invalid dates!")
                print()
                continue
            }

            for value in cryptoDict[coin]! {
                var d = dateFormatterGet.date(from: value.datetime)!
                if d >= start && d <= end {
                    print("\(value.datetime): open: \(value.open), high: \(value.high),low: \(value.low), close: \(value.close)")
                }
            }
            return
        } else {
            system("clear")
            print("\nERROR: invalid dates format!")
            print()
        }   
    }
}

print("Hello !\n " )
var exit = false
while (!exit){

    print("Choose a number :\n   1.Profile\n   2.Cryptocurrency\n   3.Exit\n")
    var str = readLine() 
    system("clear")

    switch (str){
        
        case  "1" :
            var back = false
            while(!back){
                print ("Profile:\n")
                print ("username: \(user.name) \n")
                print("Choose a number :\n   1.Change profile name\n   2.Back\n")
                str = readLine() 
                system("clear")
                switch str {
                    case "1" :
                        print ("Change profile name:\nplease enter new profile name ")
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
                print ("Cryptocurrency\n")
                
                print("List of your cryptocurrencies:")
                var i = 1
                        for coinName in user.coins{
                            print("\(i).\(coinName): \(cryptoDict[coinName]![0].close)")
                            i = i + 1
                        }
                print()
                print("Choose a number or Enter crypto name to see details:\n   1.Add Cryptocurrency\n   2.Delete Cryptocurrency\n   3.Back\n")

                str = readLine() 
                system("clear")
                
                switch str {
                    case "1" :
                        print ("Add Cryptocurrency ")
                        // print("\nAdd : with name.")
                      
                        var i = 1
                        for (coinName, values) in cryptoDict{
                            if user.coins.contains(coinName) {
                                continue
                            }
                            print("\(i).\(coinName)")
                            i = i + 1
                        }
                        print()
                        print("Enter Crypto Name:")
                        let str = readLine()!
                        system("clear")
                        let keyExists = cryptoDict[str] != nil
                        if keyExists{
                            user.coins.append(str)
                            print("\(str) added to your list.")
                        } else {
                            print("\(str) is not present in the crypto list")
                        }
                        print()
                    case "2" :
                        print ("Delete Cryptocurrency")
                        print("\nDelete: with name.")
                        var i = 1
                        for coinName in user.coins{
                            print("\(i).\(coinName)")
                            i = i + 1
                        }
                        print()
                        print("Enter Crypto Name:")
                        let str = readLine()!
                        system("clear")
                        for (i, coinName) in user.coins.enumerated(){
                            if str == coinName{
                                user.coins.remove(at: i)                                
                                print("\(str) Deleted from your list.")
                                break
                            }
                        }
                        print()
                    case "3" :
                        back = true
                    default :
                    // show selected crypto
                    if user.coins.contains(str!) {
                        // show coin
                        showcoin(coin: str!)

                        //wait for any key to back
                        print()
                        print("press Enter to back to menu ...")
                        readLine()
                        system("clear")
                    } else {
                        print ("Please enter correct number!")
                        print()
                    }
                        
                    
                } 
            
            }
            
        case  "3" :
            print("Good bye !")
            exit = true
            
        default :
            print ("Please enter correct number !")
    }
}



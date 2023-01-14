import Foundation

struct User {
    var name : String = "default";
    var coins : [String] = [];
    
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

// show a coin with details
func showcoin(coin : String){
    while true {
        print("\nYou have selected \(coin):\n")
        print("Enter start date: (yyyy-MM-dd)")
        let startDate = readLine()!
        print("Enter end date: (yyyy-MM-dd)")
        let endDate = readLine()!
        
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd"    
        
        if dateFormatterGet.date(from: startDate) != nil && dateFormatterGet.date(from: endDate) != nil{
            let start = dateFormatterGet.date(from: startDate)!
            let end = dateFormatterGet.date(from: endDate)!

            if start > end {
                system("clear")
                print("ERROR: invalid date!")
                print()
                continue
            }

            print("\nPrices of \(coin):")
            for value in cryptoDict[coin]! {
                let d = dateFormatterGet.date(from: value.datetime)!
                if d >= start && d <= end {
                    print("\(value.datetime): open: \(value.open), high: \(value.high),low: \(value.low), close: \(value.close)")
                }
            }
            return
        } else {
            system("clear")
            print("\nERROR: invalid date format!")
            print()
        }   
    }
}

// start app
system("clear")
print("Hello !\n " )
var exit = false
while (!exit){
    print("Choose a number: (Enter 0 to back from any page)\n   1.Profile\n   2.Cryptocurrency\n")
    var str = readLine() 
    system("clear")

    switch (str){
        case  "1" :
            while true{    
                print ("Profile:\n")
                print ("Your Username: \(user.name) \n")
                print ("enter new username: (enter 0 to exit)")
                str = readLine()!
                if str == "" {
                    system("clear")
                    print("ERROR: please enter valid name!\n")
                    continue
                }
                if str == "0" {
                    system("clear")
                    break
                }
                system("clear")
                user.name = str!
                print ("your profile name changed!\n")        
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
                print("Choose a number or Enter crypto name to see details:\n   1.Add Cryptocurrency\n   2.Delete Cryptocurrency\n")

                str = readLine() 
                system("clear")
                
                switch str {
                    case "1" :
                    while true {
                        print ("Add Cryptocurrency\n")
                        print("List of All cryptocurrencies:")
                        var i = 1
                        for (coinName, _) in cryptoDict{
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
                        if str == "0" {
                            break
                        }
                        let keyExists = cryptoDict[str] != nil
                        if keyExists{
                            user.coins.append(str)
                            print("\(str) added to your list.")
                        } else {
                            print("\(str) is not present in the crypto list")
                        }
                        print()
                    }
                    case "2" :
                    while true {
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
                        if str == "0" {
                            break
                        }
                        for (i, coinName) in user.coins.enumerated(){
                            if str == coinName{
                                user.coins.remove(at: i)                                
                                print("\(str) Deleted from your list.")
                                break
                            }
                        }
                        print()
                    }
                    case "0" :
                        back = true
                    default :
                    // show selected crypto
                    if user.coins.contains(str!) {
                        // show coin
                        showcoin(coin: str!)

                        //wait for any key to back
                        print()
                        print("press Enter to back to menu ...")
                        _=readLine()
                        system("clear")
                    } else {
                        print ("Please enter correct number!")
                        print()
                    }
                        
                    
                } 
            
            }
            
        case  "0" :
            print("Good bye !")
            exit = true
            
        default :
            print ("Please enter correct number !")
    }
}



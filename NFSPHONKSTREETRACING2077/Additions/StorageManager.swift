
import Foundation
import UIKit

// MARK: - Classes
final class StorageManager{
    
    private var yCoordinate : CGFloat = 200
    private var xCoordinate : CGFloat = 10
    private let scoreKey = "ScoreKey"
    private let lamboKey = "isLamboBought"
    private let yellowKey = "isYellowBought"
    private let redKey = "isRedBought"
    private let blueKey = "isBlueBought"
    
    static var shared = StorageManager()
    private var storage = UserDefaults.standard
    private init (){}
    var playersArray : [Player] {
        get{
            guard let data = storage.value(forKey: "array") as? Data,
                  let array = try? JSONDecoder().decode(Array<Player>.self, from: data) else {
                return []
            }
            return array
        }
    
        set{
            if let data = try? JSONEncoder().encode(newValue){
                storage.set(data,forKey: "array")
            }
        }
    }
    var coins : Int {
        get{
            storage.integer(forKey: scoreKey)
        }
        
        set{
            storage.set(newValue, forKey: scoreKey)
        }
    }
    
    var name: String{
        get{
            storage.string(forKey: "name") ?? ""
        }
        set{
            storage.set(newValue, forKey: "name")
        }
    }
    var isLamboBought : Bool{
        get{
            storage.bool(forKey: lamboKey)
            
        }
        set{
            storage.set(newValue, forKey: lamboKey)
        }
    }
    
    var isYellowBought : Bool{
        get{
            storage.bool(forKey: yellowKey)
        }
        set{
            storage.set(newValue, forKey: yellowKey)
        }
    }
    
    var isRedBought : Bool{
        get{
            storage.bool(forKey: redKey)
        }
        set{
            storage.set(newValue, forKey: redKey)
        }
    }
    
    var isBlueBought : Bool{
        get{
            storage.bool(forKey: blueKey)
        }
        set{
            storage.set(newValue, forKey: blueKey)
        }
    }
    
}

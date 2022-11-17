
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
    var numberArray : [UILabel] = []
    var nameArray : [UILabel] = []
    var scoreArray : [UILabel] = []
    var dateArray : [UILabel] = []

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

    func createRecords(){
        yCoordinate = 200
        if playersArray.count > 0 {
            for index in 0...playersArray.count - 1 {
              let nameString = playersArray[index].name
              let scoreString = String(playersArray[index].score)
              let dateString = playersArray[index].date
                createLabels(nameString: nameString, scoreString: scoreString, dateString: dateString, index: index)
            }
        }
        
        for index in playersArray.count...9{
            createLabels(nameString: "---", scoreString: "---", dateString: "---", index: index)
        }
    }

    func createLabels(nameString : String,scoreString : String,dateString : String,index : Int){
        let numberLabel = UILabel()
        let nameLabel = UILabel()
        let scoreLabel = UILabel()
        let dateLabel = UILabel()
        numberArray.append(numberLabel)
        nameArray.append(nameLabel)
        scoreArray.append(scoreLabel)
        dateArray.append(dateLabel)
        
        numberArray[index].font = numberArray[index].font.withSize(20)
        numberArray[index].textAlignment = .left
        numberArray[index].textColor = .white
        numberArray[index].text = "\(index+1)."
        numberArray[index].frame.size = CGSize(width: 100, height: 50)
        numberArray[index].frame.origin.x = 5
        numberArray[index].center.y = yCoordinate
        
        nameArray[index].font = nameArray[index].font.withSize(20)
        nameArray[index].textAlignment = .left
        nameArray[index].textColor = .white
        nameArray[index].text = nameString
        nameArray[index].frame.size = CGSize(width: 150, height: 50)
        nameArray[index].frame.origin.x = xCoordinate + 40
        nameArray[index].center.y = yCoordinate
        
        scoreArray[index].font = scoreArray[index].font.withSize(20)
        scoreArray[index].textAlignment = .left
        scoreArray[index].textColor = .white
        scoreArray[index].text = scoreString
        scoreArray[index].frame.size = CGSize(width: 100, height: 50)
        scoreArray[index].frame.origin.x = xCoordinate + 130
        scoreArray[index].center.y = yCoordinate
        
        dateArray[index].font = dateArray[index].font.withSize(20)
        dateArray[index].textAlignment = .left
        dateArray[index].textColor = .white
        dateArray[index].text = dateString
        dateArray[index].frame.size = CGSize(width: 200, height: 50)
        dateArray[index].frame.origin.x = xCoordinate + 220
        dateArray[index].center.y = yCoordinate
        yCoordinate += 40
    }
}





import Foundation
import UIKit

var yCooordinate : CGFloat = 200
var xCoordinate : CGFloat = 50
var playersArray : [Player] = []
var nextPlayer  = Player()
var currentPlayer = Player()
var currentNameLabel = UILabel()
var currentScoreLabel = UILabel()
var nextNameLabel = UILabel()
var nextScoreLabel = UILabel()
var sortIndex = 0
var nextWillBeLast = false
var isSortIndexExists = false

final class StorageManager{
    let scoreKey = "ScoreKey"
    let lamboKey = "isLamboBought"
    let yellowKey = "isYellowBought"
    let redKey = "isRedBought"
    let blueKey = "isBlueBought"
    static var shared = StorageManager()
    private var storage = UserDefaults.standard
    private init (){}
    
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


// MARK: - Public methods
public func updateRecords(){
    guard StorageManager.shared.name != "" else {return}
    isSortIndexExists = false
   currentScoreLabel.text = String(score)
    currentNameLabel.text = String(StorageManager.shared.name)
        ///Если первый пустой, добавляем в первого
    if UserDefaults.standard.string(forKey: "\(0)Name") == nil{
        playersArray[0].nameLabel.text = currentNameLabel.text
        playersArray[0].scoreLabel.text = currentScoreLabel.text
        UserDefaults.standard.set(playersArray[0].nameLabel.text, forKey: "\(0)Name")
        UserDefaults.standard.set(playersArray[0].scoreLabel.text, forKey: "\(0)Score")
        return
    }
    
    for index in 0...9{
        let stringScore = playersArray[index].scoreLabel.text ?? ""
        let intScore = Int(stringScore) ?? 1203102301320
        if score > intScore{
            print(score)
            print(intScore)
            sortIndex = index
            isSortIndexExists = true
            break
        }
    }
   
    if isSortIndexExists == true{
        nextWillBeLast = false
        for index in sortIndex...9{
            nextNameLabel.text = playersArray[index].nameLabel.text
            nextScoreLabel.text = playersArray[index].scoreLabel.text
            print(nextNameLabel.text)
            print(nextScoreLabel.text)
            playersArray[index].nameLabel.text = currentNameLabel.text
            playersArray[index].scoreLabel.text = currentScoreLabel.text
        
            currentNameLabel.text = nextNameLabel.text
            currentScoreLabel.text = nextScoreLabel.text
            print( currentNameLabel.text)
            print (currentScoreLabel.text)
           
            UserDefaults.standard.set(playersArray[index].nameLabel.text, forKey: "\(index)Name")
            UserDefaults.standard.set(playersArray[index].scoreLabel.text, forKey: "\(index)Score")
            if nextWillBeLast == true{
                return
            }
            if playersArray[index+1].nameLabel.text == nil || index == 8{
                nextWillBeLast = true
            }
        }
    } else{
        for index in 1...9{
            if playersArray[index].nameLabel.text == nil{
                playersArray[index].nameLabel.text = currentNameLabel.text
                playersArray[index].scoreLabel.text = currentScoreLabel.text
                UserDefaults.standard.set(playersArray[index].nameLabel.text, forKey: "\(index)Name")
                UserDefaults.standard.set(playersArray[index].scoreLabel.text, forKey: "\(index)Score")
                return
            }
        }
    }
    

}
public func createReacords(){
    yCooordinate = 130
    for index in 0...9 {
        let currentPlayer = Player()
        currentPlayer.numberLabel.text = "\(String(index+1))."
        currentPlayer.numberLabel.font =  currentPlayer.numberLabel.font.withSize(20)
        currentPlayer.numberLabel.textAlignment = .center
        currentPlayer.numberLabel.textColor = .white
        currentPlayer.numberLabel.frame.size = CGSize(width: 150, height: 50)
        currentPlayer.numberLabel.center.x = xCoordinate
        currentPlayer.numberLabel.center.y = yCooordinate
        
        currentPlayer.nameLabel.text = UserDefaults.standard.string(forKey: "\(index)Name")
        currentPlayer.nameLabel.font = currentPlayer.nameLabel.font.withSize(20)
        currentPlayer.nameLabel.textAlignment = .center
        currentPlayer.nameLabel.textColor = .white
        currentPlayer.nameLabel.frame.size = CGSize(width: 150, height: 50)
        currentPlayer.nameLabel.center.x = xCoordinate + 100
        currentPlayer.nameLabel.center.y = yCooordinate
       
        
        currentPlayer.scoreLabel.text = UserDefaults.standard.string(forKey: "\(index)Score")
        currentPlayer.scoreLabel.font = currentPlayer.scoreLabel.font.withSize(20)
        currentPlayer.scoreLabel.textAlignment = .center
        currentPlayer.scoreLabel.textColor = .white
        currentPlayer.scoreLabel.frame.size = CGSize(width: 150, height: 50)
        currentPlayer.scoreLabel.center.x = xCoordinate + 200
        currentPlayer.scoreLabel.center.y = yCooordinate
      
        
        playersArray.append(currentPlayer)
        yCooordinate += 50
        
    }
}

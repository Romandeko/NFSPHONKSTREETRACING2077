
import Foundation
import UIKit

// MARK: - Classes
final class StorageManager{
  private  var yCoordinate : CGFloat = 200
  private  var xCoordinate : CGFloat = 10
  private  let scoreKey = "ScoreKey"
  private  let lamboKey = "isLamboBought"
  private  let yellowKey = "isYellowBought"
  private  let redKey = "isRedBought"
  private  let blueKey = "isBlueBought"
    var currentScore = 0
    var playersArray : [Player] = []
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
    
    var playersCount : Int {
        get{
            storage.integer(forKey: "playersCount")
        }
        set{
            storage.set(newValue, forKey: "playersCount")
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
    
    func updateRecords(){
        guard StorageManager.shared.name != "" else {return}
        let date = Date()
        let dataFormatter = DateFormatter()
        dataFormatter.dateFormat = "dd/MM/yyyy"
        playersCount += 1
        let newPlayer = Player()
        let dateString = dataFormatter.string(from: date)
        newPlayer.nameLabel.text = String(name)
        newPlayer.scoreLabel.text = String( currentScore)
        newPlayer.dateLabel.text = dateString
        playersArray.append(newPlayer)
        playersArray.sort{ Int($0.scoreLabel.text ?? "") ?? 0 > Int($1.scoreLabel.text ?? "") ?? 0 }
        if playersCount == 11{
            playersArray.removeLast()
            playersCount -= 1
        }
        yCoordinate = 200
        for index in  0...playersCount-1{
            playersArray[index].numberLabel.text = "\(String(index+1))."
            playersArray[index].numberLabel.font =  playersArray[index].numberLabel.font.withSize(20)
            playersArray[index].numberLabel.textAlignment = .left
            playersArray[index].numberLabel.textColor = .white
            playersArray[index].numberLabel.frame.size = CGSize(width: 80, height: 50)
            playersArray[index].numberLabel.frame.origin.x = 5
            playersArray[index].numberLabel.center.y = yCoordinate
            
            playersArray[index].nameLabel.font = playersArray[index].nameLabel.font.withSize(20)
            playersArray[index].nameLabel.textAlignment = .left
            playersArray[index].nameLabel.textColor = .white
            playersArray[index].nameLabel.frame.size = CGSize(width: 100, height: 50)
            playersArray[index].nameLabel.frame.origin.x = xCoordinate + 40
            playersArray[index].nameLabel.center.y = yCoordinate
            
            playersArray[index].scoreLabel.font = playersArray[index].scoreLabel.font.withSize(20)
            playersArray[index].scoreLabel.textAlignment = .left
            playersArray[index].scoreLabel.textColor = .white
            playersArray[index].scoreLabel.frame.size = CGSize(width: 100, height: 50)
            playersArray[index].scoreLabel.frame.origin.x = xCoordinate + 130
            playersArray[index].scoreLabel.center.y = yCoordinate
            
            playersArray[index].dateLabel.font = playersArray[index].dateLabel.font.withSize(20)
            playersArray[index].dateLabel.textAlignment = .left
            playersArray[index].dateLabel.textColor = .white
            playersArray[index].dateLabel.frame.size = CGSize(width: 200, height: 50)
            playersArray[index].dateLabel.frame.origin.x = xCoordinate + 220
            playersArray[index].dateLabel.center.y = yCoordinate
            
            UserDefaults.standard.set(playersArray[index].nameLabel.text, forKey: "\(index)Name")
            UserDefaults.standard.set(playersArray[index].scoreLabel.text, forKey: "\(index)Score")
            UserDefaults.standard.set(playersArray[index].numberLabel.text, forKey: "\(index)Number")
            UserDefaults.standard.set(playersArray[index].dateLabel.text, forKey: "\(index)Date")
            yCoordinate += 40
        }
    }
    
    func createRecords(){
        if playersCount != 0{
            for index in 0...playersCount-1{
                let newPlayer = Player()
                playersArray.append(newPlayer)
                playersArray[index].nameLabel.text = UserDefaults.standard.string(forKey: "\(index)Name")
                playersArray[index].scoreLabel.text = UserDefaults.standard.string(forKey: "\(index)Score")
                playersArray[index].numberLabel.text = UserDefaults.standard.string(forKey: "\(index)Number")
                playersArray[index].dateLabel.text = UserDefaults.standard.string(forKey: "\(index)Date")
            }
            yCoordinate = 200
            for index in 0...playersCount-1{
                playersArray[index].numberLabel.font = playersArray[index].numberLabel.font.withSize(20)
                playersArray[index].numberLabel.textAlignment = .left
                playersArray[index].numberLabel.textColor = .white
                playersArray[index].numberLabel.frame.size = CGSize(width: 20, height: 50)
                playersArray[index].numberLabel.frame.origin.x = 5
                playersArray[index].numberLabel.center.y = yCoordinate
                
                playersArray[index].nameLabel.font = playersArray[index].nameLabel.font.withSize(20)
                playersArray[index].nameLabel.textAlignment = .left
                playersArray[index].nameLabel.textColor = .white
                playersArray[index].nameLabel.frame.size = CGSize(width: 150, height: 50)
                playersArray[index].nameLabel.frame.origin.x = xCoordinate + 40
                playersArray[index].nameLabel.center.y = yCoordinate
                
                playersArray[index].scoreLabel.font = playersArray[index].scoreLabel.font.withSize(20)
                playersArray[index].scoreLabel.textAlignment = .left
                playersArray[index].scoreLabel.textColor = .white
                playersArray[index].scoreLabel.frame.size = CGSize(width: 100, height: 50)
                playersArray[index].scoreLabel.frame.origin.x = StorageManager.shared.xCoordinate + 130
                playersArray[index].scoreLabel.center.y = yCoordinate
                
                playersArray[index].dateLabel.font = playersArray[index].dateLabel.font.withSize(20)
                playersArray[index].dateLabel.textAlignment = .left
                playersArray[index].dateLabel.textColor = .white
                playersArray[index].dateLabel.frame.size = CGSize(width: 200, height: 50)
                playersArray[index].dateLabel.frame.origin.x = xCoordinate + 220
                playersArray[index].dateLabel.center.y = yCoordinate
                yCoordinate += 40
            }
        }
    }
}






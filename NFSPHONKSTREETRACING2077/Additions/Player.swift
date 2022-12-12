
import Foundation
import UIKit

struct Player : Codable {
    var name : String
    var score : Int
    var date : String
}


extension Player : Equatable { }

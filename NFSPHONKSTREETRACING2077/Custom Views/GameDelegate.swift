
import Foundation

protocol GameDelegate : AnyObject {
    func gameEnded(withScore score: Int)
    func finishPassed()
    func newRecordSet(withScore score: Int)
    func cuvet()
}

extension GameDelegate{
    func gameEnded(withScore score: Int) { }
    func finishPassed() { }
    func newRecordSet(withScore score: Int) { }
    func cuvet() { }
}


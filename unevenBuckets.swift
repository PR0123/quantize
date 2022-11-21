import Foundation
import Combine
import PlaygroundSupport

let ps = PassthroughSubject<String?, Never>()

// Sending four events per second
(0..<60).forEach{ delay in
    let d = Double(delay)*0.25
    DispatchQueue.main.asyncAfter(deadline: .now()+d){
        ps.send("\(d)")
    }
}

// Pack messages to one-second buckets
// Expecting 4 in every bucket, with possible exception for the first and last
// Expectation fails every time
let c = ps
    .collect(.byTime(RunLoop.main, .seconds(1)))
    .sink { print($0) }

PlaygroundPage.current.needsIndefiniteExecution = true

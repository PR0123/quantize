import Foundation
import Combine
import PlaygroundSupport

func sendInput(){
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5){p.send("A")}
        DispatchQueue.main.asyncAfter(deadline: .now()+1.4){p.send("B")}
        DispatchQueue.main.asyncAfter(deadline: .now()+1.7){p.send("B")}
        DispatchQueue.main.asyncAfter(deadline: .now()+4.4){p.send("B")}
        DispatchQueue.main.asyncAfter(deadline: .now()+4.7){p.send("C")}
}

let t = Timer.publish(
    every: 1,
    on: .main,
    in: .common).autoconnect()

let p = PassthroughSubject<String, Never>()

let c = t.zip(p).sink { t, s in
    print(Int(t.timeIntervalSince1970)%10, s)
}

/* The closest to expected is .zip; it gives e.g.:
5 A
6 B
7 B
8 B
9 C

while expected output would give the corect timestamp/clock:

5 A
6 B
7 B
9 B
0 C

Other failed attempts started with
t.combineLatest(p).sink { t, s in
 print(Int(t.timeIntervalSince1970)%10, s)
}
p.collect(.byTime(DispatchQueue.main, 1.0)).sink {
 print($0)
}
*/

sendInput()

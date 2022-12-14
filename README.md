## How to spread incoming messages evenly, one every second, marking them with most recent timestamps, using Combine.
It requires __buffering__ messages (e.g. B) when necessary, and __omitting__ timer ticks (e.g. 4) in case there were no messages to consume, current or buffered.

<img width="413" alt="shouldBe" src="https://user-images.githubusercontent.com/81814529/204915507-8e15d178-f9a3-4b1a-b2fa-ccb1dc7d2d08.png">

I asked this question also on [the forum](https://developer.apple.com/forums/thread/721350).
There is [the code](spreadEvenly.swift) to better ilustrate the problem.



## My attempts:
<img width="410" alt="zip" src="https://user-images.githubusercontent.com/81814529/204915666-1793c358-6fd8-4576-9c04-a849e90181ac.png">
Zip operator with a timer by design outputs old past timestamps, not the latest.
If timer fire every second and the first two messages were sent in 3nd and 10th second, it would look like they were sent in 1st and 2nd second. How to overcome the problem with possibly other operator?

<img width="408" alt="repeated" src="https://user-images.githubusercontent.com/81814529/204915751-7de29ef1-50fb-4411-abc5-09ecc78f5538.png">
With  combineLatest the output is sent with every timer event by design, no matter if there was a new message sent from the other publisher. 
Filtering repeting messages is not an option, because some messages will be intentionaly repeated and should stay. How to get rid of events reusing the latest messages while none was published?

Finally with ```collect(by time)``` messages will be spread evenly but in packets, not one by one. So theoretically every element of a resulting array should be republished, which would add extra complexity.

## Is adapting withLatestFrom the right way?
I've found an [implementation of withLatestFrom](https://github.com/serhiybutz/XCombine#withlatestfrom-operator) allegedly absent from Combine, but I am not sure if adapting it is the best idea. I also believe there must be a simpler way of implementing withLatestFrom. Is there?

## Is Combine is the right tool for time-sensitive jobs. If not, what would be an alternative?
While [simulating](unevenBuckets.swift) countinuous input with asyncAfter, trying Combine's ```.collect``` introduced unexpected imprecisions observed as different number of elements in every "one second aggregate bucket".

If this is hopeless than I have [another question](https://developer.apple.com/forums/thread/721262) where time is an issue.


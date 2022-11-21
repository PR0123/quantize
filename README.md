## How to spread incoming messages evenly every second, marking them with adjusted timestamps, using Combine.
It requires buffering messages when necesery, and ommiting timer ticks in case there were no messages to consume, current or buffered.
Reference: spreadEvenly.swift

## Attempts:
## 1.
Zip operator with a timer would by design output old past timestamps, not the latest.
If timer fire every second and there are messages sent from the second publisher in 3nd and 10th second, it would look like they were sent in 1st and 2nd second. How to overcome the problem with possibly other operator?

## 2. 
With combineLatest the output is sent with every timer event by design, no matter if there was a new message sent from the other publisher. 
Filtering repeting messages is not an option, because some messages will be intentionaly repeated and should stay.
How to get rid of events reusing the latest messages while none was published?

## 3. 
With collect(by time) messages will be spread evenly but not one by one, but in packets. So theoretically every element of such array should be republished.

## 4. 
While simulating countinuous input with asyncAfter, trying Combine's .collect introduced unexpected imprecisions.
It raises the question, is it the right tool for time-sensitive jobs, like quanticizing music from live MIDI input?

# 5. 
At https://serhiybutz.medium.com/combine-withlatestfrom-operator-8c529e809fd3 I found an implementation of withLatestFrom operator missing from the Combine framework. Is the <link> the simpler but correct implematation of withLatestFrom?

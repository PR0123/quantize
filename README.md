# Goal
To align stream of messages to a given clock ticks

# Use case
Adjusting imprecize live MIDI keyboard playing to a metronomic beat

# POC
While simulating countinuous input with asyncAfter, trying Combine's .collect failed because more inprecision was introduced then reduced.
A requirement of time precision raises the question: **is this the right tool for the job?**

# On-line research
At https://serhiybutz.medium.com/combine-withlatestfrom-operator-8c529e809fd3 I found an implementation of withLatestFrom operator missing from the Combine framework. My own alternative implementation is < > but It is much shorter, which raises the question: is it oversimplified thus incorect?

# With the goal simplified to just spreading the input evenly there are other ploblems:

##1. Lack of current timestamps when using .zip with a Timer publisher:
This time the goal is simplified to just spreading the input evenly.
.zip alignes every message sent with every tick sent, so the output is evenly distributed in time as required.
Unfortunately it postpone every timestamp from a timer by design, eg. if there were messages sent in 3nd and 10th second, it would look like they were sent in 1st and 2nd second. How to overcome the problem?

##2. More output than wanted when using .combinineLast with a Timer publisher:
The output is sent with every timer event by design, no metter if there was a new message send from the other publisher. 
Filtering repeting messages is not an option, because some messages will be intentionaly repeated and should stay.
How to get rid of events reusing the latest input while none was published?


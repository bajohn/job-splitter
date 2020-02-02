# Job Splitter

This code is a testbed to experiment with splitting off complex tasks into parallel executions. Eventually these tasks will be shipped to separate lambdas in AWS.

## Demo Task

The demo task is a brute force password cracker- given a set of allowable characters, hash function, and "correct" hash, iterate through all possible passwords and stop when the correct hash is found. 

The challenge is to create a function that maps the task's sample space to an arbitrary number of subtasks.

Require: 

```
n = number of subtasks
A = sample space, for example {'aaa', 'aab' , 'aac',...}
f(A, n) = {f_1(A), f_2(A), ..., f_n(A)}
```

The functions `f_i(A)` are the subsets of the whole space `A`, and a subtask is then `g(f_i(A))`, where `g` takes care of calculating and checking hashes. 

To implement these `f` functions, the ideal solution would require a bijective mapping from the integers `0,1,2,..,|A|` to elements of the sample space `A`.

## Deploy 

-install aws cli

-add aws cli credentials

`brew install terraform`

`./script.sh`

`cd ./terraform`

`terrafrom apply`

## Local Test

`cd ./`

`pipenv run pytest`

## Current state
Needs cleanup! But 
-Get file hash to work! Not updating
-How do the worker lambdas collect their data?

Options:

Worker lambdas call singleton final lambda
- This wouldn't work because requires knowledge of state (ie has the lambda been initialized)
- No way to call existing Lambda without some other infrastructure in place

Worker lambdas call store data in a database
- How do we trigger the processing of results?
- 

Worker lambdas store data in S3
- Triggering is easier (or at least, is known)

Worker lambdas publish results to an SNS topic
- Makes sense for right answer, how about wrong answer?

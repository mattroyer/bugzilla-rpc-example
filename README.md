# bugzilla-rpc-example
Example class giving you access to bug info from Bugzilla

####Example

*Note:* You will have to change the values to use your username and password in the initialization of the class.

```
bug = Bugzilla.new '50782'

puts bug.info
puts
puts bug.comments
```

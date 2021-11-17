Iteration
====

Iteration is key to nearly every non-trivial program you will write.  In Python, one generally iterates over values rather than an index (though this is still possible using `enumerate`).  You should be careful not to mutate an object over which you are iterating in Python, as the results may be unexpected.  For example, the following code might be expected to print out three words, but stops early because the list is mutated during the loop:

```
>>> words = ['Good', 'morning', 'student']
>>> for word in words:
...     print(words.pop(0))
... 
Good
morning
>>> words
['student']
```

This is a situation where you might use a `while` loop or precompute the number of actions you'll take and use a `for` loop over your list of action indices:

```
>>> words = ['Good', 'morning', 'student']
>>> while len(words) > 0:
...     print(words.pop(0))
... 
Good
morning
student
>>> words = ['Good', 'morning', 'student']
>>> for word in range(len(words)):
...     print(words.pop(0))
... 
Good
morning
student
```

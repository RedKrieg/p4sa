Managing Data
====

Data in Python is stored in objects and each object has a type.  Some types are built in to Python, such as integers, strings, and lists.  Other types can be derived from built-in types and expand their capabilities.  In this chapter we will focus on built-in objects, enumerating common types and performing some basic operations on them.

Some built-in types can be altered and all references to them will represent the altered state.  These are "mutable" types.  Types that cannot be changed are referred to as "immutable".  Strings are immutable, but lists are mutable and as such can be changed by code.

Number types
----

Python represents numbers generally as either an `int` (integer) or a `float` (floating point).  The standard library also includes a `decimal` type for precise values where floating point precision is insufficient (working with money is a common example).  We will focus on the commonly used `int` and `float` types.

Integers are immutable.  Dividing two integers with the `/` operator will result in a `float`.  To perform integer division (discarding the remainder) use the `//` operator.

```
>>> a = 5
>>> b = 2
>>> a * b
10
>>> a / b
2.5
>>> a // b
2
>>> a % b
1
>>> b - a
-3
>>> a - b
3
```

Floats are immutable.  Floating point operations are based on the sum of the powers of `1/2` and as such cannot be precisely store numbers where the denominator is not composed of summed powers of two.  Sometimes this method of storing numbers can have surprising results.

```
>>> 1.3 + 1.3
2.6
>>> 2.3 + 0.3
2.5999999999999996
>>> 0.1 * 3
0.30000000000000004
```

Strings
----

Strings are immutable.  String operations which appear to modify a string actually return a new string instance.  For this reason, many patterns you find in other languages (using `+` to concatenate strings in a loop for example) are inefficient in Python.  Try to break strings in to smaller parts for modification and only join them together at the end of your logic.

```
>>> text = "Sphinx of black quartz, judge my vow."
>>> words = text.split()
>>> print(words[3])
quartz,
>>> words[3] = words[3].strip(',')
>>> print(" ".join(words))
Sphinx of black quartz judge my vow.
```

Here we have used the `split` function of the string `text` to create a list of words.  We remove the comma from the word at index 3 by replacing its entry in the (mutable) list of words with a stripped clone of that string, then we join the words back in to a space-separated string for printing.

Formatting allows you to use a template string and fill it with data programmatically.  Python supports the `format` function as well as `f` strings that take the current scope of names in to account.

```
>>> print("Don't {} my example please!".format(words[4]))
Don't judge my example please!
>>> print(f"Don't {words[4]} my example please!")
Don't judge my example please!
```

Lists
----

Lists are mutable.  Changing a list element does not create a new list, but instead modifies the list in place, preserving all other references to the list.  In the string example above, we replaced the text at index 3.  Now, lets build a list from individual elements.

```
>>> words = ["morning"]
>>> words.append("student")
>>> words
['morning', 'student']
>>> words.insert(0, "Good") # insert at index 0 (beginning of the list)
>>> words
['Good', 'morning', 'student']
>>> for word in words:
...     print(word)
... 
Good
morning
student
>>> words.pop(1) # remove and return an element at index 1
'morning'
>>> words.insert(1, 'afternoon') # insert a new element at index 1
>>> print(" ".join(words))
Good afternoon student
```

Tuples
----

Tuples are immutable.  It is possible for a tuple to contain a mutable object, but it is not possible to change the tuple itself.  Tuples are effectively lists that cannot be changed, but are useful for things like value unpacking (automatically splitting a tuple in to multiple variables at assignment).

```
>>> fruit = ('apple', 'orange', 'banana')
>>> apple, orange, banana = fruit
>>> print(orange)
orange
>>> sorted_fruit = apple, banana, orange
>>> sorted_fruit
('apple', 'banana', 'orange')
```

Dictionaries
----

Dictionaries are mutable.  Like lists, you can modify a dictionary at will and it will not invalidate references to the object.  Unlike lists, a dictionary uses "keys" instead of "indices".  A "key" is any hashable object, but generally you should use only strings as keys.  A dictionary is often used as a simple data structure when creating a full class is not necessary.

```
>>> student = {
...     "firstname": "Ellen",
...     "lastname": "Xample",
...     "email": "example@example.com"
... }
>>> print("Hi {}, welcome!".format(student["firstname"]))
Hi Ellen, welcome!
>>> print("{lastname}, {firstname} - {email}".format(**student))
Xample, Ellen - example@example.com
```

When iterating over a dictionary's items, both keys and values are returned.

```
>>> for key, value in student.items():
...     print(f"{key}: {value}")
... 
firstname: Ellen
lastname: Xample
email: example@example.com
```

Classes
----

A class is a mutable type of object that optionally inherits from another type.  Classes are used to associate related functions and variables in to a single object.  All built in types such as strings, lists, and dictionaries are classes and you can inherit their properties when you define your own class.  Classes will be detailed in a later chapter.

```
>>> class Bus:
...     def __init__(self, riders):
...         self.riders = riders
... 
>>> a = Bus(2)
>>> b = Bus(3)
>>> a.riders
2
>>> b.riders
3
>>> a.riders = b.riders + 2
>>> a.riders
5
```

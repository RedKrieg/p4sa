Classes
====

A class is an object with various attributes and member functions/methods within the same namespace.  This helps with organizing your code.

A basic class
----

The most basic class only needs an initialization function.  This function takes a special `self` argument first, followed by any other arguments.  The `self` argument is used by the function to reference an instance of the class itself.

```
>>> class Animal:
...     def __init__(self, name, age):
...         self.name = name
...         self.age = age
... 
```

We can instantiate a class by calling its constructor (which calls our `__init__` function, passing the new instance of the class as `self`).

```
>>> my_pet = Animal("Jake", 4)
>>> my_pet.name
'Jake'
>>> my_pet.age
4
```

Inheritance
----

We can create new classes that have the properties of existing classes, as well as new methods specific to this subclass.

```
>>> class Dog(Animal):
...     def fetch(self, toy):
...         print(f"{self.name} brings back the {toy}.")
... 
>>> my_dog = Dog("Rex", 2)
>>> my_dog.fetch("ball")
Rex brings back the ball.
>>> isinstance(my_dog, Animal)
True
>>> isinstance(my_pet, Dog)
False
```

We can use tools like `isinstance` to determine the taxonomy of an object.  In the example above we show that a dog is an Animal, but an arbitrary animal is not necessarily a Dog.

Changing the constructor when inheriting
----

If you need to change the constructor for a subclass so it accepts additional arguments, you will want to use the `super()` function to access the parent class and ensure the original `__init__` is also called properly.

```
>>> class Cat(Animal):
...     def __init__(self, name, age, neutered=False):
...         super().__init__(name, age)
...         self.neutered = neutered
... 
>>> my_cat = Cat("Chonk", 5, True)
>>> my_cat.name
'Chonk'
>>> my_cat.neutered
True
```

Of course, a class can have multiple parents, each of which are called.

```
>>> class CatDog(Cat, Dog):
...     def sleep(self):
...         print(f"{self.name} goes to bed.")
... 
>>> cd = CatDog("Weirdo", 12)
>>> cd.neutered
False
>>> cd.name
'Weirdo'
>>> isinstance(cd, Cat)
True
>>> isinstance(cd, Dog)
True
>>> cd.sleep()
Weirdo goes to bed.
```

We get away with `Dog()` in this example having no `neutered` attribute in its constructor because the constructor for `Cat()` uses a default argument of `False`.  For a much more detailed explanation of inheritance, see [Supercharge Your Classes With Python super](https://realpython.com/python-super/).

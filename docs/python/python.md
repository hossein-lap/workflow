# Python

## Syntax <!--{{{-->

Python syntax can be executed by writing directly in the Command Line:

    >>> print("Hello, World!")
    Hello, World!

Or by creating a python file on the server, using the .py file extension, and
running it in the Command Line:

    $ python myfile.py

### Indentation

Indentation refers to the spaces at the beginning of a code line.

Where in other programming languages the indentation in code is for readability
only, the indentation in Python is very important.

Python uses indentation to indicate a block of code.

```python
if 5 > 2:
    print("Five is greater than two!")
```

+ Python will give you an error if you skip the indentation

> + The number of spaces is up to you as a programmer, the most common use is
>   four, but it has to be at least one.

+ You have to use the same number of spaces in the same block of code,
  otherwise Python will give you an error

### Variables

In Python, variables are created when you assign a value to it:

```python
x = 5
y = "Hello, World!" 
```

+ Python has no command for declaring a variable.

<!--}}}-->
## Comments <!--{{{-->

Python has commenting capability for the purpose of in-code documentation.
Comments can be used to:

+ Explain Python code
+ Make the code more readable
+ Prevent execution when testing code

### Creating a Comment

Comments start with a `#` and Python will render the rest of the line as a
comment and Python will ignore them:

```python
# This is a comment
```

Comments can be placed at the end of a line, and Python will ignore the rest of
the line:

```python
print("Hello, World!") # This is a comment
```

A comment does not have to be text that explains the code, it can also be used
to prevent Python from executing code:

```python
# print("Hello, World!")
print("Cheers, Mate!")
```

### Multiline Comments

Python does not really have a syntax for multiline comments.

To add a multiline comment you could insert a `#` for each line:

```python
# This is a comment
# written in
# more than just one line
print("Hello, World!") 
```

Or, not quite as intended, you can use a multiline string.

> Since Python will ignore string literals that are not assigned to a variable,
> you can add a multiline string (triple quotes) in your code, and place your
> comment inside it

```python
"""
This is a comment
written in
more than just one line
"""
print("Hello, World!") 
```

+ As long as the string is not assigned to a variable, Python will read the
  code, but then ignore it, and you have made a multiline comment.

<!--}}}-->
## Variables <!--{{{-->

### Creating Variables

Python has no command for declaring a variable.

A variable is created the moment you first assign a value to it.

```python
x = 5
y = "John"
```

Variables do not need to be declared with any particular _type_ and can even
change type after they have been set.

```python
x = 4       # x is of type int
x = "Sally" # x is now of type str
print(x) 
```

#### Casting

If you want to specify the data type of a variable, this can be done with casting.

```python
x = str(3)    # x will be '3'
y = int(3)    # y will be 3
z = float(3)  # z will be 3.0 
```

#### Get the Type

You can get the data type of a variable with the `type()` function.

```python
x = 5
y = "John"
print(type(x))
print(type(y)) 
```

#### Single or Double Quotes?

String variables can be declared either by using single or double quotes:

```python
x = "John"
# is the same as
x = 'John'
```

#### Case-Sensitive

Variable names are case-sensitive.

```python
a = 4
A = "Sally"
# A will not overwrite a
```

### Variable Names

A variable can have a short name (like x and y) or a more descriptive name
(age, carname, total_volume). Rules for Python variables:

+ Must start with a letter or the underscore character
+ Cannot start with a number
+ Can only contain alpha-numeric characters and underscores (A-z, 0-9, and _ )
+ Variable names are case-sensitive (age, Age and AGE are three different variables)
+ Cannot be any of the Python keywords.

```python
myvar = "John"
my_var = "John"
_my_var = "John"
myVar = "John"
MYVAR = "John"
myvar2 = "John" 
```

> Remember that variable names are case-sensitive

#### Multi Words Variable Names

Variable names with more than one word can be difficult to read.

There are several techniques you can use to make them more readable:

+ Camel Case: `myVariableName`
+ Pascal Case: `MyVariableName`
+ Snake Case: `my_variable_name`

### Assign Multiple Values

#### Many Values to Multiple Variables

Python allows you to assign values to multiple variables in one line:

```python
x, y, z = "Orange", "Banana", "Cherry"
```

> **Note**: Make sure the number of variables matches the number of values, or
> else you will get an error.

#### One Value to Multiple Variables

And you can assign the same value to multiple variables in one line:

```python
x = y = z = "Orange"
```

#### Unpack a Collection

If you have a collection of values in a list, tuple etc. Python allows you to
extract the values into variables. This is called _unpacking_.

```python
fruits = ["apple", "banana", "cherry"]
x, y, z = fruits
```

### Output Variables

The Python `print()` function is often used to output variables.

```python
x = "Python is awesome"
print(x)
```

In the `print()` function, you output multiple variables, separated by a comma:

```python
x = "Python"
y = "is"
z = "awesome"
print(x, y, z) 
```

You can also use the `+` operator to output multiple variables:

```python
x = "Python "
y = "is "
z = "awesome"
print(x + y + z) 
```

> Notice the space character after `"Python "` and `"is "` without them the
> result would be "Pythonisawesome".

For numbers, the `+` character works as a mathematical operator:

```python
x = 5
y = 10
print(x + y) 
```

> In the `print()` function, when you try to combine a string and a number with
> the `+` operator, Python will give you an error

The best way to output multiple variables in the `print()` function is to
separate them with commas, which even support different data types:

```python
x = 5
y = "John"
print(x, y)
```

### Global Variables

Variables that are created outside of a function (as in all of the examples
above) are known as global variables.

Global variables can be used by everyone, both inside of functions and outside.

```python
x = "awesome"

def myfunc():
    print("Python is " + x)

myfunc() 
```

If you create a variable with the same name inside a function, this variable
will be local, and can only be used inside the function. The global variable
with the same name will remain as it was, global and with the original value.

```python
x = "awesome"

def myfunc():
    x = "fantastic"
    print("Python is " + x)

myfunc()

print("Python is " + x) 
```

#### The global Keyword

Normally, when you create a variable inside a function, that variable is local,
and can only be used inside that function.

To create a global variable inside a function, you can use the `global`
keyword.

```python
def myfunc():
    global x
    x = "fantastic"

myfunc()

print("Python is " + x) 
```

Also, use the `global` keyword if you want to change a global variable inside a
function.

```python
x = "awesome"

def myfunc():
    global x
    x = "fantastic"

myfunc()

print("Python is " + x) 
```

<!--}}}-->
## Data Types <!--{{{-->

### Built-in Data Types

In programming, data type is an important concept.

Variables can store data of different types, and different types can do
different things.

Python has the following data types built-in by default, in these categories:

|                 |                                     |
|:----------------|:------------------------------------|
|  Text Type      |  `str`                              |
|  Numeric Types  |  `int`, `float`, `complex`          |
|  Sequence Types |  `list`, `tuple`, `range`           |
|  Mapping Type   |  `dict`                             |
|  Set Types      |  `set`, `frozenset`                 |
|  Boolean Type   |  `bool`                             |
|  Binary Types   |  `bytes`, `bytearray`, `memoryview` |
|  None Type      |  `NoneType`                         |

### Getting the Data Type

You can get the data type of any object by using the `type()` function:

```python
x = 5
print(type(x)) 
```

### Setting the Data Type

In Python, the data type is set when you assign a value to a variable:

|  **Example**                                  |  **Data Type** |
|:----------------------------------------------|:---------------|
|  `x = "Hello World"`                            | `str`        |
|  `x = 20`                                       | `int`        |
|  `x = 20.5`                                     | `float`      |
|  `x = 1j`                                       | `complex`    |
|  `x = ["apple", "banana", "cherry"]`            | `list`       |
|  `x = ("apple", "banana", "cherry")`            | `tuple`      |
|  `x = range(6)`                                 | `range`      |
|  `x = {"name" : "John", "age" : 36}`            | `dict`       |
|  `x = {"apple", "banana", "cherry"}`            | `set`        |
|  `x = frozenset({"apple", "banana", "cherry"})` | `frozenset`  |
|  `x = True`                                     | `bool`       |
|  `x = b"Hello"`                                 | `bytes`      |
|  `x = bytearray(5)`                             | `bytearray`  |
|  `x = memoryview(bytes(5))`                     | `memoryview` |
|  `x = None`                                     | `NoneType`   |

### Setting the Specific Data Type

If you want to specify the data type, you can use the following constructor
functions:

|  **Example**                                  |  **Data Type** |
|:----------------------------------------------|:---------------|
|  `x = str("Hello World")`                       | `str`        |
|  `x = int(20)`                                  | `int`        |
|  `x = float(20.5)`                              | `float`      |
|  `x = complex(1j)`                              | `complex`    |
|  `x = list(("apple", "banana", "cherry"))`      | `list`       |
|  `x = tuple(("apple", "banana", "cherry"))`     | `tuple`      |
|  `x = range(6)`                                 | `range`      |
|  `x = dict(name="John", age=36)`                | `dict`       |
|  `x = set(("apple", "banana", "cherry"))`       | `set`        |
|  `x = frozenset(("apple", "banana", "cherry"))` | `frozenset`  |
|  `x = bool(5)`                                  | `bool`       |
|  `x = bytes(5)`                                 | `bytes`      |
|  `x = bytearray(5)`                             | `bytearray`  |
|  `x = memoryview(bytes(5))`                     | `memoryview` |

<!--}}}-->
## Numbers <!--{{{-->

There are three numeric types in Python:

+ `int`
+ `float`
+ `complex`

Variables of numeric types are created when you assign a value to them:

```python
x = 1    # int
y = 2.8  # float
z = 1j   # complex
```

To verify the type of any object in Python, use the `type()` function:

```python
print(type(x))
print(type(y))
print(type(z))
```

### int

Int, or integer, is a whole number, positive or negative, without decimals, of
unlimited length.

```python
x = 1
y = 35656222554887711
z = -3255522
print(type(x))
print(type(y))
print(type(z))
```

### float

Float, or "floating point number" is a number, positive or negative, containing
one or more decimals.

```python
x = 1.10
y = 1.0
z = -35.59
print(type(x))
print(type(y))
print(type(z)) 
```

Float can also be scientific numbers with an "e" to indicate the power of 10.

```python
x = 35e3
y = 12E4
z = -87.7e100
```

### complex

Complex numbers are written with a "j" as the imaginary part:

```python
x = 3+5j
y = 5j
z = -5j
print(type(x))
print(type(y))
print(type(z)) 
```

### Type Conversion

You can convert from one type to another with the `int()`, `float()`, and
`complex()` methods:

```python
x = 1    # int
y = 2.8  # float
z = 1j   # complex
# convert from int to float:
a = float(x)
# convert from float to int:
b = int(y)
# convert from int to complex:
c = complex(x)
print(a)
print(b)
print(c)
print(type(a))
print(type(b))
print(type(c)) 
```

> **Note**: You cannot convert complex numbers into another number type.

### Random Number

Python does not have a `random()` function to make a random number, but Python
has a built-in module called `random` that can be used to make random numbers:

```python
import random
print(random.randrange(1, 10)) 
```

<!--}}}-->
## Casting <!--{{{-->

### Specify a Variable Type

There may be times when you want to specify a type on to a variable. This can
be done with casting. Python is an object-orientated language, and as such it
uses classes to define data types, including its primitive types.

Casting in python is therefore done using constructor functions:

+ **`int()`** - constructs an integer number from an integer literal, a float
  literal (by removing all decimals), or a string literal (providing the string
  represents a whole number)
+ **`float()`** - constructs a float number from an integer literal, a float
  literal or a string literal (providing the string represents a float or an
  integer)
+ **`str()`** - constructs a string from a wide variety of data types,
  including strings, integer literals and float literals

#### int

```python
x = int(1)   # x will be 1
y = int(2.8) # y will be 2
z = int("3") # z will be 3
```

#### float

```python
x = float(1)     # x will be 1.0
y = float(2.8)   # y will be 2.8
z = float("3")   # z will be 3.0
w = float("4.2") # w will be 4.2
```

#### string

```python
x = str("s1") # x will be 's1'
y = str(2)    # y will be '2'
z = str(3.0)  # z will be '3.0'
```

<!--}}}-->
## Strings <!--{{{-->

Strings in python are surrounded by either single quotation marks, or double
quotation marks.

`'hello'` is the same as `"hello"`.

You can display a string literal with the `print()` function:

```python
print("Hello")
print('Hello') 
```

### Assign String to a Variable

Assigning a string to a variable is done with the variable name followed by an
equal sign and the string:

```python
a = "Hello"
print(a) 
```

#### Multiline Strings

You can assign a multiline string to a variable by using three quotes:

```python
a = """Lorem ipsum dolor sit amet,
consectetur adipiscing elit,
sed do eiusmod tempor incididunt
ut labore et dolore magna aliqua."""
print(a) 
```

Or three single quotes.

> **Note**: in the result, the line breaks are inserted at the same position as
> in the code.

#### Strings are Arrays

Like many other popular programming languages, strings in Python are arrays of
bytes representing unicode characters.

However, Python does not have a character data type, a single character is
simply a string with a length of 1.

Square brackets can be used to access elements of the string.

```python
a = "Hello, World!"
print(a[1]) 
```

#### Looping Through a String

Since strings are arrays, we can loop through the characters in a string, with
a `for` loop.

```python
for x in "banana":
    print(x) 
```

#### String Length

To get the length of a string, use the `len()` function.

```python
a = "Hello, World!"
print(len(a))
```

#### Check String

To check if a certain phrase or character is present in a string, we can use
the keyword `in`.

```python
txt = "The best things in life are free!"
print("free" in txt)
```

Use it in an `if` statement:

```python
txt = "The best things in life are free!"
if "free" in txt:
    print("Yes, 'free' is present.") 
```

#### Check if NOT

To check if a certain phrase or character is NOT present in a string, we can
use the keyword `not in`.

```python
txt = "The best things in life are free!"
print("expensive" not in txt) 
```

Use it in an `if` statement:

```python
txt = "The best things in life are free!"
if "expensive" not in txt:
    print("No, 'expensive' is NOT present.") 
```

### Slicing

You can return a range of characters by using the slice syntax.

Specify the start index and the end index, separated by a colon, to return a
part of the string.

```python
b = "Hello, World!"
print(b[2:5])
```

> **Note**: The first character has index 0.

#### Slice From the Start

```python
b = "Hello, World!"
print(b[:5])
```

#### Slice To the End

By leaving out the end index, the range will go to the end:

```python
b = "Hello, World!"
print(b[2:])
```

#### Negative Indexing

Use negative indexes to start the slice from the end of the string:

```python
b = "Hello, World!"
print(b[-5:-2]) 
```

### Modify Strings

Python has a set of built-in methods that you can use on strings.

#### Upper Case

```python
a = "Hello, World!"
print(a.upper())
```

#### Lower Case

```python
a = "Hello, World!"
print(a.lower())
```

#### Remove Whitespace

Whitespace is the space before and/or after the actual text, and very often you
want to remove this space.

```python
a = " Hello, World!   "
print(a.strip()) # returns "Hello, World!" 
```

#### Replace String

```python
a = "Hello, World!"
print(a.replace("H", "J"))
```

#### Split String

The `split()` method returns a list where the text between the specified
separator becomes the list items.

```python
a = "Hello, World!"
print(a.split(",")) # returns ['Hello', ' World!']
```

### String Concatenation

To concatenate, or combine, two strings you can use the + operator.

```python
a = "Hello"
b = "World"
c = a + " " + b
print(c) 
```

### String Format

The `format()` method takes the passed arguments, formats them, and places them
in the string where the placeholders `{}` are:

```python
age = 36
txt = "My name is John, and I am {}"
print(txt.format(age)) 
```

The format() method takes unlimited number of arguments, and are placed into
the respective placeholders:

```python
quantity = 3
itemno = 567
price = 49.95
myorder = "I want {} pieces of item {} for {} dollars."
print(myorder.format(quantity, itemno, price)) 
```

You can use index numbers `{0}` to be sure the arguments are placed in the
correct placeholders:

```python
quantity = 3
itemno = 567
price = 49.95
myorder = "I want to pay {2} dollars for {0} pieces of item {1}."
print(myorder.format(quantity, itemno, price)) 
```

### Escape Character

To insert characters that are illegal in a string, use an escape character.

An escape character is a backslash `\` followed by the character you want to insert.


An example of an illegal character is a double quote inside a string that is
surrounded by double quotes:

```python
txt = "We are the so-called "Vikings" from the north." 
```

To fix this problem, use the escape character `\"`:

```python
txt = "We are the so-called \"Vikings\" from the north." 
```

Other escape characters used in Python:

|  **Code** |  **Result**    |
|:---------:|:---------------|
|  `\'`   |  Single Quote    |
|  `\\`   |  Backslash       |
|  `\n`   |  New Line        |
|  `\r`   |  Carriage Return |
|  `\t`   |  Tab             |
|  `\b`   |  Backspace       |
|  `\f`   |  Form Feed       |
|  `\ooo` |  Octal value     |
|  `\xhh` |  Hex value       |

### String Methods

Python has a set of built-in methods that you can use on strings.

> **Note**: All string methods return new values. They do not change the
> original string.

|  **Method** |  **Description** |
|:-----------:|:-----------------|
|  `capitalize()` | Converts the first character to upper case |
|  `casefold()` | Converts string into lower case |
|  `center()` | Returns a centered string |
|  `count()` | Returns the number of times a specified value occurs in a string |
|  `encode()` | Returns an encoded version of the string |
|  `endswith()` | Returns true if the string ends with the specified value |
|  `expandtabs()` | Sets the tab size of the string |
|  `find()` | Searches the string for a specified value and returns the position of where it was found |
|  `format()` | Formats specified values in a string |
|  `format_map()` | Formats specified values in a string |
|  `index()` | Searches the string for a specified value and returns the position of where it was found |
|  `isalnum()` | Returns True if all characters in the string are alphanumeric |
|  `isalpha()` | Returns True if all characters in the string are in the alphabet |
|  `isdecimal()` | Returns True if all characters in the string are decimals |
|  `isdigit()` | Returns True if all characters in the string are digits |
|  `isidentifier()` | Returns True if the string is an identifier |
|  `islower()` | Returns True if all characters in the string are lower case |
|  `isnumeric()` | Returns True if all characters in the string are numeric |
|  `isprintable()` | Returns True if all characters in the string are printable |
|  `isspace()` | Returns True if all characters in the string are whitespaces |
|  `istitle()` | Returns True if the string follows the rules of a title |
|  `isupper()` | Returns True if all characters in the string are upper case |
|  `join()` | Joins the elements of an iterable to the end of the string |
|  `ljust()` | Returns a left justified version of the string |
|  `lower()` | Converts a string into lower case |
|  `lstrip()` | Returns a left trim version of the string |
|  `maketrans()` | Returns a translation table to be used in translations |
|  `partition()` | Returns a tuple where the string is parted into three parts |
|  `replace()` | Returns a string where a specified value is replaced with a specified value |
|  `rfind()` | Searches the string for a specified value and returns the last position of where it was found |
|  `rindex()` | Searches the string for a specified value and returns the last position of where it was found |
|  `rjust()` | Returns a right justified version of the string |
|  `rpartition()` | Returns a tuple where the string is parted into three parts |
|  `rsplit()` | Splits the string at the specified separator, and returns a list |
|  `rstrip()` | Returns a right trim version of the string |
|  `split()` | Splits the string at the specified separator, and returns a list |
|  `splitlines()` | Splits the string at line breaks and returns a list |
|  `startswith()` | Returns true if the string starts with the specified value |
|  `strip()` | Returns a trimmed version of the string |
|  `swapcase()` | Swaps cases, lower case becomes upper case and vice versa |
|  `title()` | Converts the first character of each word to upper case |
|  `translate()` | Returns a translated string |
|  `upper()` | Converts a string into upper case |
|  `zfill()` | Fills the string with a specified number of 0 values at the beginning |

<!--}}}-->
## Boolean <!--{{{-->

Booleans represent one of two values: `True` or `False`.

In programming you often need to know if an expression is `True` or `False`.

You can evaluate any expression in Python, and get one of two answers, `True`
or `False`.

When you compare two values, the expression is evaluated and Python returns the
Boolean answer:

```python
print(10 > 9)
print(10 == 9)
print(10 < 9) 
```

When you run a condition in an if statement, Python returns `True` or `False`:

```python
a = 200
b = 33

if b > a:
    print("b is greater than a")
else:
    print("b is not greater than a")
```

### Evaluate Values and Variables

The `bool()` function allows you to evaluate any value, and give you `True` or
`False` in return.

```python
print(bool("Hello"))
print(bool(15))
```

```python
x = "Hello"
y = 15

print(bool(x))
print(bool(y))
```

### Most Values are True

Almost any value is evaluated to `True` if it has some sort of content.

Any string is `True`, except empty strings.

Any number is `True`, except `0`.

Any list, tuple, set, and dictionary are `True`, except empty ones.

```python
bool("abc")
bool(123)
bool(["apple", "cherry", "banana"])
```

### Some Values are False

In fact, there are not many values that evaluate to `False`, except empty
values, such as `()`, `[]`, `{}`, `""`, the number `0`, and the value `None`.
And of course the value `False` evaluates to `False`.

```python
bool(False)
bool(None)
bool(0)
bool("")
bool(())
bool([])
bool({}) 
```

One more value, or object in this case, evaluates to `False`, and that is if
you have an object that is made from a class with a `__len__` function that
returns `0` or `False`: 

```python
class myclass():
    def __len__(self):
        return 0

myobj = myclass()
print(bool(myobj)) 
```

### Functions can Return a Boolean

You can create functions that returns a Boolean Value:

```python
def myFunction():
    return True

print(myFunction()) 
```

You can execute code based on the Boolean answer of a function:

```python
def myFunction():
    return True

if myFunction():
    print("YES!")
else:
    print("NO!") 
```

Python also has many built-in functions that return a boolean value, like the
`isinstance()` function, which can be used to determine if an object is of a
certain data type:

```python
x = 200
print(isinstance(x, int)) 
```

<!--}}}-->
## Operators <!--{{{-->

Operators are used to perform operations on variables and values.

In the example below, we use the `+` operator to add together two values:

```python
print(10 + 5)
```

Python divides the operators in the following groups:

+ Arithmetic operators
+ Assignment operators
+ Comparison operators
+ Logical operators
+ Identity operators
+ Membership operators
+ Bitwise operators

### Arithmetic Operators

Arithmetic operators are used with numeric values to perform common
mathematical operations:

| **Operator** | **Name** | **Example** |
|:------------:|:---------|:------------|
| `+` | Addition | `x + y` | 
| `-` | Subtraction | `x - y` | 
| `*` | Multiplication | `x * y` | 
| `/` | Division | `x / y` | 
| `%` | Modulus | `x % y` | 
| `**` | Exponentiation | `x ** y` | 
| `//` | Floor division | `x // y` | 

### Assignment Operators

Assignment operators are used to assign values to variables:

| **Operator** | **Example** | **Same As** |
|:-------------|:---------|:------------|
| `=` | `x = 5` | `x = 5` |
| `+=` | `x += 3` | `x = x + 3` |
| `-=` | `x -= 3` | `x = x - 3` |
| `*=` | `x *= 3` | `x = x * 3` |
| `/=` | `x /= 3` | `x = x / 3` |
| `%=` | `x %= 3` | `x = x % 3` |
| `//=` | `x //= 3` | `x = x // 3` |
| `**=` | `x **= 3` | `x = x ** 3` |
| `&=` | `x &= 3` | `x = x & 3` |
| `|=` | `x |= 3` | `x = x | 3` |
| `^=` | `x ^= 3` | `x = x ^ 3` |
| `>>=` | `x >>= 3` | `x = x >> 3` |
| `<<=` | `x <<= 3` | `x = x << 3` |

### Comparison Operators

Comparison operators are used to compare two values:

| **Operator** | **Name** | **Example** |
|:------------:|:---------|:------------|
| `==` | Equal | `x == y` | 
| `!=` | Not equal | `x != y` | 
| `>` | Greater than | `x > y` | 
| `<` | Less than | `x < y` | 
| `>=` | Greater than or equal to | `x >= y` | 
| `<=` | Less than or equal to | `x <= y` | 

### Logical Operators

Logical operators are used to combine conditional statements:

| **Operator** | **Description** | **Example** |
|:------------:|:---------|:------------|
| `and ` | Returns True if both statements are true | `x < 5 and  x < 10` | 
| `or` | Returns True if one of the statements is true | `x < 5 or x < 4` | 
| `not` | Reverse the result, returns False if the result is true | `not(x < 5 and x < 10)` | 

### Identity Operators

Identity operators are used to compare the objects, not if they are equal, but
if they are actually the same object, with the same memory location:

| **Operator** | **Description** | **Example** |
|:------------:|:---------|:------------|
| `is ` | Returns True if both variables are the same object | `x is y` | 
| `is not` | Returns True if both variables are not the same object | `x is not y` | 


### Membership Operators

Membership operators are used to test if a sequence is presented in an object:

| **Operator** | **Description** | **Example** |
|:------------:|:---------|:------------|
| `in ` | Returns True if a sequence with the specified value is present in the object | `x in y` | 
| `not in` | Returns True if a sequence with the specified value is not present in the object | `x not in y` | 

### Bitwise Operators

| **Operator** | **Name** | **Description** | **Example** |
|:------------:|:---------|:----------------|:------------|
| `& ` | **AND** | Sets each bit to 1 if both bits are 1 | `x & y` | 
| `|` | **OR** | Sets each bit to 1 if one of two bits is 1 | `x | y` | 
| `^` | **XOR** | Sets each bit to 1 if only one of two bits is 1 | `x ^ y` | 
| `~` | **NOT** | Inverts all the bits | `~x` | 
| `<<` | **Zero fill left shift** | Shift left by pushing zeros in from the right and let the leftmost bits fall off | `x << 2` | 
| `>>` | **Signed right shift** | Shift right by pushing copies of the leftmost bit in from the left, and let the rightmost bits fall off | `x >> 2` | 

### Operator Precedence

Operator precedence describes the order in which operations are performed.

Parentheses has the highest precedence, meaning that expressions inside
parentheses must be evaluated first:

```python
print((6 + 3) - (6 + 3))
```

Multiplication `*` has higher precedence than addition `+` and therefor
multiplications are evaluated before additions:

```python
print(100 + 5 * 3)
```

The precedence order is described in the table below, starting with the highest
precedence at the top:

| **Operator** | **Description** |
|:------------:|:----------------|
| `()` | Parentheses | 
| `**` | Exponentiation | 
| `+x` `-x` `~x` | Unary plus, unary minus, and bitwise NOT | 
| `*` `/` `//` `%` | Multiplication, division, floor division, and modulus | 
| `+` `-` | Addition and subtraction | 
| `<<` `>>` | Bitwise left and right shifts | 
| `&` | Bitwise AND | 
| `^` | Bitwise XOR | 
| `|` | Bitwise OR | 
| `==` `!=` `>` `>=` `<` `<=` `is` `is not` `in` `not in` | Comparisons, identity, and membership operators | 
| `not` | Logical NOT | 
| `and` | AND | 
| `or` | OR | 

+ If two operators have the same precedence, the expression is evaluated from left to right.

```python
print(5 + 4 - 7 + 3)
```

<!--}}}-->

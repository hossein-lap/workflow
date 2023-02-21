# Bash Cheatsheet

This document contains
[bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell))
specific commands / syntax which may not be
completely POSIX complaint.

POSIX complaint shell scripting doc will be ready after this one ;)

## Variables <!--{{{-->

- **Define**

```bash
name='PJ'
age=10
os=$(uname)
```

- **Use**

```bash
echo $name
printf '- %s\n' \
		$age \
		$os
```

- **Execute**

```
$ bash tmp.sh
```

- or if it has shebang and execute permission

```
$ ./tmp.sh
PJ
- 10
- Linux
$_
```

- **Length**

```bash
a='Hello World'
b=1917
echo ${#a} # 11
echo ${#b} # 4
```

### Special Variables

| **Variable** | **Description** |
|:-------------|:----------------|
| `$0` | Name of script |
| `$1, $2, $3, ...` | First, Second, Third, ... argument of script |
| `$#` | Number of arguments were passed to the script |
| `$@` | All arguments of the script (can be iterated) |
| `$*` | All arguments of the script (cannot be iterated) |
| `$?` | Return value of the last execution in script |
| `$$` | The PID of the script |
| `$USER` | The user which is running the script (username) |
| `$HOSTNAME` | The host name of the machine |
| `$LINENO` | Current line number inside script |
| `$RANDOM` | Random number |

<!--}}}-->
## Input <!--{{{-->

- **Basic**

```bash
read input_variable
echo ${input_variable}
```

- **with prompt message**

```bash
read -p 'are you sure? ' input_variable
```

- **silent input**

```bash
read -sp 'Input is silent: ' input_variable
```

<!--}}}-->
## Arrays <!--{{{-->

- **Define**

```bash
files=('f1.txt' 'f2.txt' 'f3.txt')
echo ${files[0]} # the first element
echo ${files[*]} # all elements
echo ${files[@]} # same
echo ${#files} # size/length of array
```

- **Add elements**

```bash
files+=('f4.txt')
```

- **Remove elements**

```bash
unset files[0]
```

<!--}}}-->
## Arithmetic <!--{{{-->

### Basic Expressions

| **Operator** | **Operation** |
|:-------------|:--------------|
| `+` | Addition |
| `-` | Subtraction |
| `*` | Multiply |
| `/` | Deviation |
| `%` | Remainder |
| `var++` | Increase by 1 |
| `var--` | Decrease by 1 |

- **let**

```bash
let a=4+5 # 9
let 'A = 4 + 6' # 10
let a++ # 10
let A-- # 9
```

- **expr**

```bash
var_two=$( expr 4 \* 5 ) # 20
```

- **Double Parentheses**

```bash
a=$((3 + 5)) # 8
b=$(( a + 3 )) # 11
(( b++ )) # 12
```

<!--}}}-->
## Conditions <!--{{{-->

- **Test Operations**

| **Operator** | **Operation** |
|:-------------|:--------------|
| `!`   | Not |

- **String Operations**

| **Operator** | **Operation** |
|:-------------|:--------------|
| `-z`  | Is null |
| `-n`  | Is not null |
| `==`  | Is equal |
| `!=`  | Is not equal |

- **Numerical Operations**

| **Operator** | **Operation** |
|:-------------|:--------------|
| `-eq` | equal |
| `-lt` | less than |
| `-gt` | greater than |
| `-le` | less-equal to |
| `-ge` | greater-equal to |

- **File Operations**

| **Operator** | **Operation** |
|:-------------|:--------------|
| `-e`  | Exists |
| `-d`  | Exists and it's a directory |
| `-f`  | Exists and it's a file |
| `-r`  | Exists and has *read* permission |
| `-w`  | Exists and has *write* permission |
| `-x`  | Exists and has *execute* permission |
| `-s`  | Exists and it's not empty |


### if <!--{{{-->

- **Basic**

```bash
if [[ `echo $(date +%s) % 5 | bc` -eq 0 ]]; then
	echo "It can be devided by 5 without any reminder"
elif [[ ${second_condition} ]]; then
	echo "The second is true"
else
	printf '%s\n' \
		"Nothing is true" \
		"Everything is permitted"
fi
```

- **Nested**

```bash
if [[ 10 -gt 5 ]]; then
	echo True
	if (( 10 % 2 == 0 )); then
		echo and Even
	fi
fi
```

- **In-line**

```bash
[[ ${some_condition} ]] && echo "it's true" || echo 'false'
```

- **Boolean Operation**

```bash
if [[ -r $1 ]] && [[ -s $1 ]]; then
	echo "$1 has read permission and contains some data"
fi
```

<!--}}}-->
### case <!--{{{-->

- **Basic**

```bash
case $TERM in
	xterm)
		PS1="[\u@\h \w]\$ "
	;;
	xterm-256colors)
		PS1="\[\033[01;34m\]\u@\h\[\033[00m\]:\[\033[01;32m\]\W\[\033[00m\]\$ "
	;;
	*)
		PS1='$ '
	;;
esac
```

- **(Un)capitalized**

```bash
case $1 in
	-[hH])
		help
	;;
	-[vV])
		version
	;;
	-[yY])
		choice=true
	;;
esac
```
<!--}}}-->

<!--}}}-->
## Loops <!--{{{-->

- **for** <!--{{{-->

```bash
for i in {1..10}
do
	echo ${i}
done
```

<!--}}}-->
- **while** <!--{{{-->

```bash
counter=1
while [[ ${counter} -le 9 ]]; do
	echo "${counter}"
	((counter++))
done
```

<!--}}}-->
- **until** <!--{{{-->

```bash
counter=1
until [[ ${counter} -gt 9 ]]
do
	echo "${counter}"
	((counter++))
done
```

<!--}}}-->
- **select** <!--{{{-->

```bash
names='Kyle Cartman Stan Quit'
PS3='Select character: '
select name in ${names}; do
	if [[ $name == 'Quit' ]]; then
		break
	fi
	echo Hello ${name}
done
echo Bye
```

<!--}}}-->
### Controlling Loops: `break` and `continue` <!--{{{-->

- **break**

```bash
for value in $1/*; do
	used=$(df $1 | tail -1 | awk '{print $5;}' | sed 's/%//')
	if [[ ${used} -gt 90 ]]; then
		echo Low disk space > /dev/stderr
		break
	fi
	cp $value $1/backup/
done
```
<!--}}}-->

<!--}}}-->
## Functions <!--{{{-->

- **Define**

```bash
# first
name() {
	<commands>
}
# second
function name() {
	<commands>
}
```

- **Call the function**

```bash
print_something() {
	echo "Hello World!"
}
print_something
```

- **Passing arguments**

```bash
say_hello_to() {
	echo "Hello ${1}!"
}
say_hello_to Mars
```

- ***return* value**
```bash
return_something() {
	return ${RANDOM}
}
return_something
echo "The previous function returned $?"
```
- **Variable scope**
```bash
the_variable='This is global'
echo "Outside of function: ${the_variable}"
change_var() {
	local the_variable='This is local'
	echo "Inside of function: ${the_variable}"
}
echo "Outside of function: ${the_variable}"
change_var
echo "Outside of function: ${the_variable}"
```
- **Overwriting commands**
```bash
ls() {
	command ls -lhgX
}
ls
```
<!--}}}-->

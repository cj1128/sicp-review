# Structure and Interpretation of Computer Programs

![](./cover.jpg)

## First Things First

- Env: Mac OSX 10.10
  
- `brew install x11/mit-scheme`
  
- emacs: `M-x: run-scheme`
  
- sublime text scheme building system:
  
  ``` json
  {
    "shell_cmd": "mit-scheme --quiet < $file",
    "file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)",
    "selector": "source.scheme"
  }
  ```

## Mit Scheme

- `(begin (exp1) (exp2) ...)` evaluates expressions in sequence

## Charpter 1

- normal-order evaluation vs applicative-order evaluation
  
  > “fully expand and then reduce” evaluation is known as normal-order evaluation , in contrast to the “evaluate the arguments and then apply” method that is called applicative-order evaluation

## Charpter 3

- referentially transparent
  
  > A language that supports the concept that “equals can be substituted for equals” in an expression without changing the value of the expression is said to be referentially transparent. (Page 315)




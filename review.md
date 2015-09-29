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

## Charpter 1

## normal-order evaluation vs applicative-order evaluation

> “fully expand and then reduce” evaluation is known as normal-order evaluation , in contrast to the “evaluate the arguments and then apply” method that is called applicative-order evaluation
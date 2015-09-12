# Structure and Interpretation of Computer Programs



## First Things First

- Env: Mac OSX 10.10
  
- `brew install x11/mit-scheme`
  
- sublime text scheme building system:
  
  ``` json
  {
    "shell_cmd": "mit-scheme --quiet < $file",
    "file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)",
    "selector": "source.scheme"
  }
  ```
  
  ​
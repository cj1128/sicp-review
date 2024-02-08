# Review of Structure and Interpretation of Computer Programs

My review of the awesome SICP book.

> I think that it's extraordinarily important that we in computer science **keep fun** in computing.
> --- Alan J. Perlis

![](./assets/cover.jpg)

Useful links:

- [Mit Scheme Reference](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref.pdf)
- [Mit Scheme User's Manual](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-user.pdf)

TOC:

- [Setup](#setup)
  - [Sublime Text](#sublime-text)
  - [VS Code](#vs-code)
- [Chapter 1: Building Abstractions with Procedures](#chapter-1-building-abstractions-with-procedures)
  - [1.1: The Elements of Programming](#11-the-elements-of-programming)
- [Exercise](#exercise)
  - [1.1](#11)
  - [1.2](#12)
  - [1.3](#13)
  - [1.4](#14)
  - [1.5](#15)
  - [1.6](#16)
  - [1.7](#17)
  - [1.8](#18)

## Setup

- `mit-scheme`: MIT/GNU Scheme 12.1

For Mac OS

```bash
brew install mit-scheme
brew install rlwrap
cp REPO/scheme-completion.txt ~/scheme-completion.txt
echo 'alias sicp="rlwrap -r -c -f ~/scheme-completion.txt mit-scheme"' >> ~/.zshrc
```

### Sublime Text

Configure the build system:

```json
{
  "shell_cmd": "run-mit-scheme $file",
  "file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)",
  "selector": "source.scheme"
}
```

I wrap `mit-scheme` program in `run-mit-scheme` script to append trailing new line so that the build result looks better in https://packagecontrol.io/packages/BuildX[BuildX].

```bash
$ cat run-mit-scheme
#!/bin/bash
result=$(mit-scheme --quiet < $1)
code=$?

echo "$result"
exit $code
```

### VS Code

`.vscode/tasks.json` file defines a task to run scheme file.

```json
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Run Current File",
      "type": "shell",
      "command": "mit-scheme --quiet < ${file}",
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "presentation": {
        "echo": true,
        "reveal": "always",
        "panel": "shared",
        "showReuseMessage": false,
        "clear": true
      }
    }
  ]
}
```

Add following keybinding to make it more convenient.

```json
{
    "key": "ctrl+b",
    "command": "workbench.action.tasks.runTask",
    "args": "Run Current File"
}
```

## Chapter 1: Building Abstractions with Procedures

- Lisp is so old and also so good.
  > Lisp was invented in the late 1950s as a formalism for reasoning about the use of certain kinds of logical expressions, called *recursion equations*, as a model for computation. The language was conceived by John McCarthy and is based on his paper “Recursive Functions of Symbolic Expressions and Their Computation by Machine”.
  > --- page3
- Why use Lisp in this book?
  > If Lisp is not a mainstream language, why are we using it as the framework for our discussion of programming? Because the language possesses unique features that make it an excellent medium for studying important programming constructs and data structures and for relating them to the linguistic features that support them. The most significant of these features is the fact that Lisp descriptions of processes, called procedures, can themselves be represented and manipulated as Lisp data.
  > --- page5

### 1.1: The Elements of Programming

- One of the key features of every programming language is *how to combine simple ideas to form more complex ideas*.
  >Every powerful language has three mechanisms for accomplishing this:
  >
  >* *primitive expressions*, which represent the simplest entities the language is concerned with,
  >* *means of combination*, by which compound elements are built from simpler ones, and
  >* *means of abstraction*, by which compound elements can be named and manipulated as units.
  > --- page6
- In Lisp, every expression has a value.
- Name matters.
  >A critical aspect of a programming language is the means it provides for using names to refer to computational objects.
  > --- page10
- Some expressions do not follow general evaluation rule. They are special so they are called `special forms`, like `(define x 1)`.
  >Such exceptions to the general evaluation rule are called special forms. ... Each special form has its own evaluation rule. The various kinds of expressions (each with its associated evaluation rule) constitute the syntax of the programming language.
  > --- page14

- Lisp has a very simple syntax.
  >In comparison with most other programming languages, Lisp has a very simple syntax; that is, the evaluation rule for expressions can be described by a simple general rule together with specialized rules for a small number of special forms.
  > --- page15
- Applicative order versus normal order.
  >This alternative “fully expand and then reduce” evaluation is known as normal-order evaluation , in contrast to the “evaluate the arguments and then apply” method that the interpreter actually uses, which is called applicative-order evaluation.
  > --- page21
- Lisp *uses applicative-order evaluation*.
  >Lisp uses applicative-order evaluation, partly because of the additional efficiency obtained from avoiding multiple evaluations of expres- sions ... and, more significantly, because normal-order evaluation becomes much more complicated to deal with when we leave the realm of procedures that can be modeled by substitution. On the other hand, normal-order evaluation can be an extremely valuable tool.
  > --- page21
  - Normal order evaluation can be an extremely valuable tool.
- Use `cond` special form to handle conditional expressions.
  - There are two constants `#t` and `#f` in Scheme.
  - Scheme interprets `#f` as false and any other value is treated as true, Providing `#t` is logically unnecessary, but it's convenident.
  - `if` special form is a restricted type of `cond`
- How to compute square roots?
  >How does one compute square roots? Thee most common way is to use Newton’s method of successive approximations, which says that whenever we have a guess y for the value of the square root of a number x , we can perform a simple manipulation to get a better guess (one closer to the actual square root) by averaging y with x/y.
  > --- page29
  - NOTE: MIT Scheme, however, distinguishes between exact integers and decimal values, and dividing two integers produces a rational number rather than a decimal.
  - [sqrt.scm](./chapter-1/1.1/sqrt.scm)
- We can define functions inside functions.
  >we allow a procedure to have internal definitions that are local to that procedure. Such nesting of definitions, called block structure, is basically the right solution to the simplest name-packaging problem.
  > --- page38
- What is *lexical scoping*?
  >Lexical scoping dictates that free variables in a procedure are taken to refer to bindings made by enclosing procedure definitions; that is, they are looked up in the environment in which the procedure was defined.
  > --- page39

## Exercise

### 1.1

The best way to know what result is printed by the interpreter is to actually type the expression to the interpreter.

### 1.2

We can clearly see the benefits of the syntax of Lisp. It's so concise yet powerful.

[1.2.scm](./chapter-1/1.1/1.2.scm)

### 1.3

[1.3.scm](./chapter-1/1.1/1.3.scm)

### 1.4

```scheme
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

In this function, the operator itself is a subexpression `(if (> b 0) + -)`. It is either built-in procedure `+` or built-in procedure `-` based on the value of `b`.

In Lisp, operator and operands can be any complex expressions.

### 1.5

```scheme
(define (p) (p))

(define (test x y)
  (if (= x 0) 0 y))

(test 0 (p))
```

In normal-order evaluator, the program would run normally, return 0. But in applicative-order evaluator, the program would hang forever.

Because in application-order evaluator, when it evaluates `(test 0 (p))`, it will need to evaluate `(p)` first.

`p` is a procedure which calls itself. So to evaluate `(p)`, we get `(p)` again, and we evaluate that, we get it again, so on and so forth, we can never get a result.

But in normal-order evaluator, it won't evaluate operands until it has to. So `(test 0 (p))` becomes `(if (= 0 0) 0 (p)`. Because `(= 0 0)` is true, it will never evaluate `(p)`.

### 1.6

The procedure would hang forever because it continuously evaluates `sqrt-iter`.

### 1.7

For small numbers, the result will be inaccurate. Let's say we need to iterate 10 times to find the square root of number x, because x is very small, the first time iterated value and x can satisfy the `good-enough?` condition.

```scheme
(display (square (sqrt 1e-5)))
; 9.832294718753643e-4
; clearly inaccurate sqrt
```

For big numbers, the program will run forever. We can never find a guess to satisfy the condition because we only have limited precision.

```scheme
; CAUTION! this function will run forever
(display (sqrt 1.797693134862315708145274237317043567981e+308))
```

Does it help with the new `good-enough?` implementation? Of course!

Check new implementation at [1.7.scm](./chapter-1/1.1/1.7.scm)

### 1.8

[1.8.scm](./chapter-1/1.1/1.8.scm)

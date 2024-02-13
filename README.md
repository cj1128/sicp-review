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
- [Chrome](#chrome)
- [Chapter 1: Building Abstractions with Procedures](#chapter-1-building-abstractions-with-procedures)
  - [1.1: The Elements of Programming](#11-the-elements-of-programming)
  - [1.2: Procedures and the Processes They Generate](#12-procedures-and-the-processes-they-generate)
- [Exercise](#exercise)
  - [1.1](#11)
  - [1.2](#12)
  - [1.3](#13)
  - [1.4](#14)
  - [1.5](#15)
  - [1.6](#16)
  - [1.7](#17)
  - [1.8](#18)
  - [1.9](#19)
  - [1.10](#110)
  - [1.11](#111)
  - [1.12](#112)
  - [1.13](#113)

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

## Chrome

Install [Markdown Viewer](https://chromewebstore.google.com/detail/markdown-viewer/ckkdlimhmcjmikdlpkmbgfkaikojcbjk) plugin to preview this file in Chrome.

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

### 1.2: Procedures and the Processes They Generate

- Recursive process::
  ```scheme
  (define (factorial n)
    (if (= n 1)
        1
        (* n (factorial (- n 1)))))

  (factorial 6)
  (* 6 (factorial 5))
  (* 6 (* 5 (factorial 4)))
  (* 6 (* 5 (* 4 (factorial 3))))
  (* 6 (* 5 (* 4 (* 3 (factorial 2)))))
  (* 6 (* 5 (* 4 (* 3 (* 2 (factorial 1))))))
  (* 6 (* 5 (* 4 (* 3 (* 2 1)))))
  (* 6 (* 5 (* 4 (* 3 2))))
  (* 6 (* 5 (* 4 6)))
  (* 6 (* 5 24))
  (* 6 120)
  ; A linear recursion
  ```
  >This type of process, characterized by a chain of deferred operations, is called a *recursive process*. Carrying out this process requires that the interpreter keep track of the operations to be performed later on.
  > ---page 44
- Iterative process::
  ```scheme
  (define (factorial n)
    (define (fact-iter product counter max-count)
      (if (> counter max-count)
          product
          (fact-iter (* product counter) (+ counter 1) max-count)))
    (fact-iter 1 1 n))

  (factorial 6)
  (fact-iter 1 1 6)
  (fact-iter 1 2 6)
  (fact-iter 2 3 6)
  (fact-iter 6 4 6)
  (fact-iter 24 5 6)
  (fact-iter 120 6 6)
  (fact-iter 720 7 6)
  ```
  >By contrast, the second process does not grow and shrink. At each step, all we need to keep track of, for any n, are the current values of the variables `product`, `counter`, and `max-count`. We call this an *iterative process*.
  > --- page44
- The essential feature of _iterative process_ is that *its state can be summarized by a fixed number of state variables*.
  >In general, an iterative process is one whose state can be summarized by a fixed number of state variables, together with a fixed rule that describes how the state variables should be updated as the process moves from state to state and an (optional) end test that specifies conditions under which the process should terminate.
  > --- page44
- Pay attention that a recursive *process* is not the same as a recursive *procedure*. We can use a skill called *Tail Call Optimization* to get an iterative process of a recursive procedure.
  - In my understanding, process is the running entity and procedure is the static code.
  > When we describe a procedure as recursive, we are referring to the syntactic fact that the procedure definition refers (either directly or indirectly) to the procedure itself. But when we describe a process as following a pattern that is, say, linearly recursive, we are speaking about how the process evolves, not about the syntax of how a procedure is written.
  > --- page45
- Calculating fibonacci is a typical *tree recursive* process
  > In general, the number of steps required by a tree-recursive process will be proportional to the number of nodes in the tree, while the space required will be proportional to the maximum depth of the tree.
  > --- page49
- How many different ways can we make change of $1.00, given half-dollars, quarters, dimes, nickels, and pennies?
  - This problem has a simple solution as a [recursive procedure](./chapter-1/1.2/count-change.scm).
  - It's not obvious how to transform this to an iterative process. I managed to come up with [one](./chapter-1/1.2/count-change-iter.scm), but I have to say it's hard to understand.
  > A tree-recursive process may be highly inefficient but often easy to specify and understand
  > --- page53
- We can use *memoization* to dramatically reduce time and space usage of tree-recursive process

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

### 1.9

```scheme
(define (+ a b)
  (if (= a 0) b (inc (+ (dec a) b))))

(+ 4 5)
;(inc (+ 3 5))
;(inc (inc (+ 2 5)))
;(inc (inc (inc (+ 1 5))))
;(inc (inc (inc (inc (+ 0 5)))))
;(inc (inc (inc (inc 5))))
;(inc (inc (inc 6)))
;(inc (inc 7))
;(inc 8)
9

; this is a recursive process.
```

```scheme
(define (+ a b)
  (if (= a 0) b (+ (dec a) (inc b))))

(+ 4 5)
;(+ 3 6)
;(+ 2 7)
;(+ 1 8)
;(+ 0 9)
9

; this is an iterative process.
```

### 1.10

[1.10.scm](./chapter-1/1.2/1.10.scm)

### 1.11

The recursive version is very easy, just follow the formula.

Because this function is a slight modification of `fibonacci`, we can use the same skill to construct the iterative function.

[1.11.scm](./chapter-1/1.2/1.11.scm)

### 1.12

It's obvious that `f(row, index) = f(row-1, index-1) + f(row-1, index)`.

[1.12.scm](./chapter-1/1.2/1.12.scm)

### 1.13

Let's first prove that

$$
Fib(n) =  \frac{\phi^{n} - \psi^{n}}{\sqrt{5}} \\
$$

Given

$$
\begin{gathered}
\phi = \frac{1 + \sqrt{5}}{2} \\
\psi = \frac{1 - \sqrt{5}}{2} \\
Fib(n) = Fib(n)  + Fib(n-1)
\end{gathered}
$$

If

$$
\begin{align}
Fib(n) &= \frac{\phi^n - \psi^n}{\sqrt{5}} \\
Fib(n-1) &= \frac{\phi^{n-1} - \psi^{n-1}}{\sqrt{5}} \\
\end{align}
$$

Because

$$
\begin{align}
\phi\psi = -1 \\
\phi + \psi = 1 \\
\end{align}
$$

We can get

$$
\begin{align}
\phi^{n+1} - \psi^{n+1} & = \phi\phi^n - \psi\psi^{n} \\
& = (1 - \psi)\phi^n - (1 - \phi)\psi^n \\
& = \phi^n - \psi\phi^n - \psi^n + \phi\psi^n \\
& = \phi^n - \psi\phi\phi^{n-1} - \psi^n + \phi\psi\psi^{n-1} \\
& = \phi^n - \psi^n + \phi^{n-1} - \psi^{n-1} \\

\\

Fib(n+1) & = Fib(n) + Fib(n-1) \\
& = \frac{\phi^n - \psi^n + \phi^{n-1} - \psi^{n-1}}{\sqrt{5}} \\
& = \frac{\phi^{n+1} - \psi^{n+1}}{\sqrt{5}}
\end{align}
$$

To prove that $Fib(n)$ is the closest integer to $\frac{\phi^{n}}{\sqrt{5}}$, All we have to do is to prove that

$$
\begin{align}
\left| Fib(n) - \frac{\phi^n}{\sqrt{5}} \right| < \frac{1}{2} \\
\left| \frac{\phi^n}{\sqrt{5}} - \frac{\psi^n}{\sqrt{5}} - \frac{\phi^n}{\sqrt{5}} \right| < \frac{1}{2} \\
\left| \frac{\psi^n}{\sqrt{5}} \right| < \frac{1}{2} \\
\left| \frac{\psi^n}{\sqrt{5}} \right| < \frac{1}{2} \\
\left| \psi^n \right| < \frac{\sqrt{5}}{2} \\
(\frac{\sqrt{5} - 1}{2})^n < \frac{\sqrt{5}}{2}
\end{align}
$$

Because $\sqrt{5} > 2$, so all we have to prove is

$$
(\frac{\sqrt{5} - 1}{2})^n <= 1
$$

Because $0 < \frac{\sqrt{5} - 1}{2} < 1$, so based on the properties of exponential functions, the above is true.

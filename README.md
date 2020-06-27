<div align="center">
  <h1>
    Structure and Interpretation of Computer Programs
  </h1>

  <img src="./cover.jpg">
</div>

My review of the awesome SICP book.

Useful links:

- [Official site for SICP](https://mitpress.mit.edu/sites/default/files/sicp/index.html)
- [Mit Scheme Reference](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-ref.pdf)
- [Mit Scheme User's Manual](https://www.gnu.org/software/mit-scheme/documentation/stable/mit-scheme-user.pdf)

## Setup

For Mac OS:

1. `brew install mit-scheme`
2. `brew install rlwrap`
3. `cp REPO/scheme-completion.txt ~/scheme-completion.txt`
4. `echo 'alias sicp="rlwrap -r -c -f ~/scheme-completion.txt mit-scheme"' >> ~/.zshrc`

If you are using Sublime Text, you can configure the build system:

``` json
{
  "shell_cmd": "run-mit-scheme $file",
  "file_regex": "^[ ]*File \"(...*?)\", line ([0-9]*)",
  "selector": "source.scheme"
}
```

I wrap `mit-scheme` in `run-mit-scheme` to append trailing new line so that the build result looks better in [BuildX](https://packagecontrol.io/packages/BuildX).

`cat run-mit-scheme`:

```bash
#!/bin/bash
result=$(mit-scheme --quiet < $1)
code=$?

echo "$result"
exit $code
```

## TOC

<!-- MarkdownTOC -->

- [Charpter 1: Building Abstractions with Procedures](#charpter-1-building-abstractions-with-procedures)
  - [1.1: The Elements of Programming](#11-the-elements-of-programming)
    - [Exercise 1.1](#exercise-11)
    - [Exercise 1.2](#exercise-12)
    - [Exercise 1.3](#exercise-13)
    - [Exercise 1.4](#exercise-14)
    - [Exercise 1.5](#exercise-15)
- [Mit Scheme](#mit-scheme)

<!-- /MarkdownTOC -->

## Charpter 1: Building Abstractions with Procedures

Lisp is so old and also so good.

> Lisp was invented in the late 1950s as a formalism for reasoning about the use of certain kinds of logical expressions, called *recursion equations*, as a model for computation. The language was conceived by John McCarthy and is based on his paper “Recursive Functions of Symbolic Expressions and Their Computation by Machine”.

Why SICP chooses lisp?

> If Lisp is not a mainstream language, why are we using it as the framework for our discussion of programming? Because the language possesses unique features that make it an excellent medium for studying important programming constructs and data structures and for relating them to the linguistic features that support them.

### 1.1: The Elements of Programming

One of the key features of every programming language is **how to combine simple ideas to form more complex ideas**.

> Every powerful language has three mechanisms for accomplishing this:
> - primitive expressions, which represent the simplest entities the language is concerned with,
> - means of combination, by which compound elements are built from simpler ones, and
> - means of abstraction, by which compound elements can be named and manipulated as units.

Name matters.

> A critical aspect of a programming language is the means it provides for using names to refer to computational objects.

Some expressions do not follow general evaluation rule. They are special, like `(define x 1)`.

> Such exceptions to the general evaluation rule are called special forms. ... Each special form has its own evalu- ation rule. The various kinds of expressions (each with its associated evaluation rule) constitute the syntax of the programming language.

Lisp has a very simple syntax.

> In comparison with most other programming languages, Lisp has a very simple syntax; that is, the evaluation rule for expressions can be described by a simple general rule together with specialized rules for a small number of special forms.

Applicative order versus normal order.

> This alternative “fully expand and then reduce” evaluation is known as normal-order evaluation , in contrast to the “evaluate the arguments and then apply” method that the interpreter actually uses, which is called applicative-order evaluation.

Lisp uses applicative-order evaluation.

> Lisp uses applicative-order evaluation, partly because of the additional efficiency obtained from avoiding multiple evaluations of expres- sions ... and, more significantly, because normal-order evaluation becomes much more complicated to deal with when we leave the realm of procedures that can be modeled by substitution. On the other hand, normal-order evaluation can be an extremely valuable tool.

#### Exercise 1.1

```scheme
10 ; 10

(+ 5 3 4) ; 12

(- 9 1) ; 8

(/ 6 2) ; 3

(+ (* 2 4) (- 4 6)) ; 6

(define a 3) ; a

(define b (+ a 1)) ; b

(+ a b (* a b)) ; 19

(= a b) ; #f

(if (and (> b a) (< b (* a b)))
    b
    a) ; 4

(cond
  ((= a 4) 6)
  ((= b 4) (+ 6 7 a))
  (else 25)) ; 16

(+ 2 (if (> b a) b a)) ; 6

(* (cond ((> a b) a)
         ((< a b) b)
         (else -1))
   (+ a 1)) ; 16
```

#### Exercise 1.2

We can clearly see the benefits of the syntax of Lisp. It's so concise yet powerful.

[1.02.scm](./chapter-1/1.1/1.02.scm).

#### Exercise 1.3

[1.03.scm](./chapter-1/1.1/1.03.scm).

#### Exercise 1.4

```scheme
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
```

In this function, the operator itself is a subexpression `(if (> b 0) + -)`. It is either built-in procedure `+` or built-in procedure `-` based on the value of `b`.

In Lisp, operator and operands can be any complex expressions.

#### Exercise 1.5

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

## Mit Scheme

- `(begin (exp1) (exp2) ...)` evaluates expressions in sequence


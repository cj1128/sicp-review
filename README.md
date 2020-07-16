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

- [Chapter 1: Building Abstractions with Procedures](#chapter-1-building-abstractions-with-procedures)
  - [1.1: The Elements of Programming](#11-the-elements-of-programming)
    - [Exercise 1.1](#exercise-11)
    - [Exercise 1.2](#exercise-12)
    - [Exercise 1.3](#exercise-13)
    - [Exercise 1.4](#exercise-14)
    - [Exercise 1.5](#exercise-15)
    - [Exercise 1.6](#exercise-16)
    - [Exercise 1.7](#exercise-17)
    - [Exercise 1.8](#exercise-18)
  - [1.2: Procedures and the Processes They Generate](#12-procedures-and-the-processes-they-generate)
    - [Exercise 1.9](#exercise-19)
    - [Exercise 1.10](#exercise-110)
    - [Exercise 1.11](#exercise-111)
    - [Exercise 1.12](#exercise-112)
    - [Exercise 1.13](#exercise-113)
    - [Exercise 1.14](#exercise-114)
    - [Exercise 1.15](#exercise-115)
    - [Exercise 1.16](#exercise-116)
    - [Exercise 1.17](#exercise-117)
    - [Exercise 1.18](#exercise-118)
    - [Exercise 1.19](#exercise-119)
- [Mit Scheme](#mit-scheme)
- [Reference](#reference)

<!-- /MarkdownTOC -->

## Chapter 1: Building Abstractions with Procedures

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

Some expressions do not follow general evaluation rule. They are special so they are called `special forms`, like `(define x 1)`.

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

---

How to compute square roots?

> How does one compute square roots? Thee most common way is to use Newton’s method of successive approximations, which says that whenever we have a guess y for the value of the square root of a number x , we can perform a simple manipulation to get a better guess (one closer to the actual square root) by averaging y with x/y.

NOTE that in MIT Scheme, we get rational numbers if we divide two integers.

> MIT Scheme, however, distinguishes between exact integers and decimal values, and dividing two integers produces a rational number rather than a decimal.

#### Exercise 1.6

The procedure would hang forever because it continuously evaluates `sqrt-iter`.

#### Exercise 1.7

For small numbers, the result will be inaccurate. Let's say we need to iterate 10 times to find the square root of number x, because x is very small, the first time iterated value and x can satisfy the `good-enough?` condition.

```scheme
(display (sqrt 0.00001))
; .03135649010771716
; this value is very inaccurate
```

For big numbers, the program will run forever. We can never find a number to satisfy the condition because we only have limited precision.

```scheme
; CAUTION! this function will run forever
(display (sqrt 1.797693134862315708145274237317043567981e+308))
```

Does it help with the new `good-enough?` implementation? Of course! See the code here [1.07.scm](./chapter-1/1.1/1.07.scm).

```scheme
; very small number
(display (sqrt 0.00001))
(newline)
; 3.172028655357483e-3

; very large number
(display (sqrt 1.797693134862315708145274237317043567981e+308))
(newline)
; 1.3407807929942597e154
```

#### Exercise 1.8

[1.08.scm](./chapter-1/1.1/1.08.scm).

---

We can define functions inside functions.

>  ... we allow a procedure to have internal definitions that are local to that procedure. Such nesting of definitions, called block structure, is basically the right solution to the simplest name-packaging problem.

What is *lexical scoping*?

> Lexical scoping dictates that free variables in a procedure are taken to refer to bindings made by enclosing procedure definitions; that is, they are looked up in the environment in which the procedure was defined.

### 1.2: Procedures and the Processes They Generate

**Recursive process** and **Iterative process**.

Recursive:

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

> This type of process, characterized by a chain of deferred operations, is called a *recursive process*. Carrying out this process requires that the interpreter keep track of the operations to be performed later on.

Iterative:

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

> By contrast, the second process does not grow and shrink. At each step, all we need to keep track of, for any n, are the current values of the variables `product`, `counter`, and `max-count`. We call this an *iterative process*.

> In general, an iterative process is one whose state can be summarized by a fixed number of state variables, together with a fixed rule that describes how the state variables should be updated as the process moves from state to state and an (optional) end test that specifies conditions under which the process should terminate.

*Recursive process* is not the same as *recursive procedure*. We can use a skill called *Tail Call Optimization* to get an iterative process of a recursive procedure.

In my understanding, process is the running entity and procedure is the static code.

> When we describe a procedure as recursive, we are referring to the syntactic fact that the procedure definition refers (either directly or indirectly) to the procedure itself. But when we describe a process as following a pattern that is, say, linearly recursive, we are speaking about how the process evolves, not about the syntax of how a procedure is written.

#### Exercise 1.9

```scheme
(define (+ a b)
  (if (= a 0) b (inc (+ (dec a) b))))

(+ 4 5)
(inc (+ 3 5))
(inc (inc (+ 2 5)))
(inc (inc (inc (+ 1 5))))
(inc (inc (inc (inc (+ 0 5)))))
(inc (inc (inc (inc 5))))
(inc (inc (inc 6)))
(inc (inc 7))
(inc 8)
9

; this is a recursive process.
```

```scheme
(define (+ a b)
  (if (= a 0) b (+ (dec a) (inc b))))

(+ 4 5)
(+ 3 6)
(+ 2 7)
(+ 1 8)
(+ 0 9)
9

; this is a iterative process.
```

#### Exercise 1.10

```scheme
; Ackermann’s function
(define (A x y) (cond ((= y 0) 0)
  ((= x 0) (* 2 y))
  ((= y 1) 2)
  (else (A (- x 1) (A x (- y 1))))))

; (A 1 10)
; -> (A 0 (A 1 9))
; -> (A 0 (A 0 (A 1 8)))
; -> (A 0 (A 0 (A 0 (A 1 7))))
; -> (A 0 (A 0 (A 0 (A 0 (A 1 6)))))
; ...
; 2^10 = 1024
; So, (A 1 x) means 2^x

; (A 2 4)
; -> (A 1 (A 2 3))
; -> (A 1 (A 1 (A 2 2)))
; -> (A 1 (A 1 (A 1 (A 2 1))))
; -> (A 1 (A 1 (A 1 2)))
; ...
; 2^(2^(2^2)) = 2^16 = 65536
; So, (A 2 x) means 2^(2^(2^...)) number of 2 is x

; (A 3 3)
; -> (A 2 (A 3 2))
; -> (A 2 (A 2 (A 3 1)))
; -> (A 2 (A 2 2))
; ...
; -> (A 2 4)
; 2^(2^(2^2)) = 2^16 = 65536

(define (f n) (A 0 n)) ; 2n
(define (g n) (A 1 n)) ; 2^n
(define (h n) (A 2 n)) ; 2^(2^(2^(...))) number of 2 is n
```

---

How many different ways can we make change of $1.00, given half-dollars, quarters, dimes, nickels, and pennies?

This problem has a simple solution as a recursive procedure. See [count-change](./chapter-1/1.2/count-change.scm).

It's not obvious how to transform it to a iterative process. This is one possible solution [count-change-iter.scm](./chapter-1/1.2/count-change-iter.scm).

#### Exercise 1.11

Write the recursive version is very easy, just follow the formula.

This function is a slight modification of `fibonacci`, we can use the same skill to construct the iterative function.

[1.11.scm](./chapter-1/1.2/1.11.scm)

#### Exercise 1.12

It's obvious that `f(row, index) = f(row-1, index-1) + f(row-1, index)`.

[1.12.scm](./chapter-1/1.2/1.12.scm)

#### Exercise 1.13

[1.13.html](./formulas/1.13.html)

---

`Big O` notation only provides a rough description.

> Orders of growth provide only a crude description of the behavior of a process. For example, a process requiring n^2 steps and a process requiring 1000n^2 steps and a process requiring 3n^2 + 10n + 17 steps all have O(n^2) order of growth.

But it's still very useful.

> On the other hand, order of growth provides a useful indication of how we may expect the behavior of the process to change as we change the size of the problem.

#### Exercise 1.14

Dark node is the leaf node.

![](./assets/1.14.png)

The space complexity is the depth of the tree, and we can see that is `O(n)`.

The time complexity is hard to analyze. The result is `cc(amount, kind) = O(amount^kind)`. Here is a [detail explaination](https://codology.net/post/sicp-solution-exercise-1-14/).

#### Exercise 1.15

We need to get sine's argument down to 0.1 by dividing 12.15 by 121.5 or greater number. Every time `p` is applied, argument gets divided by 3. How many times we need to divide 12.15 by 3 to get down to 0.1? We need to find out the x from x^3 = 121.5

```scheme
; x^3 = 121.5
; x = log3(121.5) = log(121.5) / log(3)
(display (/ (log 121.5) (log 3))) ; 4.37
; So p will be applied 5 times.
```

Space and time complexity of `(sine a)` are both `log3(a)`.

#### Exercise 1.16

[1.16.scm](./chapter-1/1.2/1.16.scm).

> In general, the technique of defining an invariant quantity that remains unchanged from state to state is a powerful way to think about the design of iterative algorithms.

#### Exercise 1.17

[1.17.scm](./chapter-1/1.2/1.17.scm).

#### Exercise 1.18

[1.18.scm](./chapter-1/1.2/1.18.scm).

#### Exercise 1.19

> Recall the transformation of the state variables a and b in the fib-iter process of Section 1.2.2: `a = a + b` and `b = a`. Call this transformation T, and observe that applying T over and over again n times, starting with 1 and 0, produces the pair Fib(n + 1) and Fib(n). In other words, the Fibonacci numbers are produced by applying T^n , the nth power of the transformation T, starting with the pair (1, 0).

```text
p' = p^2 + q^2
q' = q^2 + 2pq

Applying T(p,q) twice equals to applying T(p', q') once.
```

## Mit Scheme

- `(begin (exp1) (exp2) ...)` evaluates expressions in sequence

## Reference

- https://github.com/sarabander/p2pu-sicp
- https://codology.net/

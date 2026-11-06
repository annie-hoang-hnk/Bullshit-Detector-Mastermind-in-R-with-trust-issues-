# Bullshit-Detector-Mastermind-in-R-with-trust-issues-
Group 11 · Introduction to Statistics for Data Science · Week 3 game

---

## Why this game?

This is part of our groupwork projects in week 3, ideally making a game in R.  Examples were dice-rolling games, which are a nice way to play with randomness in R, but our group wanted to try something a bit different, so we went slightly out of the box.

We took the classic code-breaking game **Mastermind** and gave it a twist: **the game doesn't always tell you the truth.** (which is a fun little add-on since we thought the game is not "statistical" enough). 

---

## How to play?

1. The computer picks a secret code of **4 digits**, each from **1 to 6** (repeats allowed).
2. You type a guess, e.g. `1234`.
3. You get feedback:

| Symbol | Meaning |
|:---:|---|
| ⦿ | Right digit, **right** place |
| ○ | Right digit, **wrong** place |
| (Nothing) | None of your digits are in the code |

4. Keep guessing until you get **⦿⦿⦿⦿**. The game tells you how many turns you took.

---

## The twist

On every turn there's a **10% chance** the feedback is completely made up: a random number of ⦿ and ○.

So if the clues suddenly contradict everything you've learned so far... maybe it's not you. It might be the game. Trust your logic, not the feedback. That's where the name comes from. 

---

## How to run?

The game uses `readline()`, so it needs an **interactive** R session.

**RStudio (recommended):** open `Mastermind_Example.R` and click **Source**.

**R console:**
```r
source("Mastermind_Example.R")
```

> Running it with `Rscript` from the terminal won't work properly, because `readline()` doesn't wait for input in non-interactive mode.

---

## How the code works

| Function | What it does |
|---|---|
| `show_rules()` | Prints the rules and feedback symbols |
| `read_guess()` | Reads your input and keeps asking until it's 4 digits from 1–6 |
| `calculate_feedback()` | Counts ⦿ (exact matches) and ○ (right digit, wrong place), then with probability 0.1 replaces them with random values |
| `bullshitdetector()` | Main game loop: creates the secret code, runs the turns, ends when you hit 4 ⦿ |

---

## A bit of statistics

Since this is a stats module, here's the probability behind the game:

- **Possible codes:** 6⁴ = **1,296**
- **Chance a given turn is honest:** 0.9
- **Chance all of n turns are honest:** 0.9ⁿ. After 7 turns that's only about **48%**, so in a typical game you'll probably be lied to at least once.
- Each turn's lie is a **Bernoulli(0.1)** trial, so the number of lies in a game follows a **Binomial(n, 0.1)** distribution.

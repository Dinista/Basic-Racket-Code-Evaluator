# Basic-Racket-Code-Evaluator

## Introduction
This is a basic racket implementation of a <b>Racket language code evaluator</b> based on specific metrics. It's the second and final project for class LFPP (Logic and functional programming paradigms).

## Research on Metrics
A research was made defining a group of metrics for code evaluation. Those metrics were applied in the implementation as base to evaluate the code.
<br>There's a portuguese article formalizing this research, on path: <i>/docs</i></br>

## How to use

### Input

The input is a <i>.txt</i> file containing the racket source code, it also evaluates more then one file... 


### Output

The output is a list of metrics based on the source code, such as:
<ul style = "color: red;">
<li>Total number of lines;</li>
<li>Total number of comments;</li>
<li>Total number of functions greater than five lines.</li>
</ul>

A weighting it's applied on each metric, and it's used to calculate a final score for the respective source code.

## Analysis and tests
A group of racket source codes with the same proprouse was choosen and passed through the algorithm. A portuguese article was written analysing those results. In path <i>/docs</i> you can find the analysis article.


#### Tests

A unit test was implemented for each function.


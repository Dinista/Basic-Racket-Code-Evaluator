# Basic-Racket-Code-Evaluator

## Introduction
This is a basic racket implementation of a <b>Racket language code evaluator</b> based on specific metrics. It's the second and final project for class LFPP (Logic and functional programming paradigms).

## Research on Metrics
<p>A research was made defining a group of metrics for code evaluation. Those metrics were applied in the implementation as base to evaluate the code.</p>
<p>There's a portuguese article formalizing this research, in the folder: <i>/docs</i></p>

## How to use
You can run the program in DrRacket calling the function main, typing:

    (main)

Unit tests are executed automatically when the code is compiled.

### Input

<p>The input is a <i>.rkt</i> file containing the racket source code, it also evaluates more then one file.</p>
<p>All the codes to be evaluated <b>must be in the folder: <i>/files</i></b></p>


### Output

The output is a list of metrics based on the source code, such as:
<ul style = "color: red;">
<li>Total number of lines;</li>
<li>Total number of comments;</li>
<li>Total number of lines greater than 80 characters;</li>
<li>Total number of defines;</li>
<li>Total number of requires;</li>
<li>Total number of unit tests;</li>
</ul>

A weighting it's applied on each metric, and it's used to calculate a <b>final score</b> for the respective source code.

## Analysis and tests
<p>A group of racket source codes with the same proprouse was choosen and passed through the algorithm. </p>
<p>Those codes are in the folder<i>/files</i> .</p>
<p>A portuguese article was written analysing those results. In the folder <i>/docs</i> you can find the analysis article.</p>


#### Tests

A unit test was implemented for each function.


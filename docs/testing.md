# Testing

This document outlines the testing strategy for the Messages repository.

## General Approach

The testing approach for this repository focuses on behavioral verification using the `@dashkite/amen` testing framework alongside `@dashkite/assert` for making assertions. Tests are written in CoffeeScript to mirror the library's implementation language.

The test suite validates the core capabilities of the `Messages` class, ensuring that message templates are correctly added, retrieved, and interpolated. By utilizing small, isolated test cases that run assertions against expected text outputs, the suite guarantees that context interpolation accurately replaces placeholders and that hierarchical paths correctly resolve to the appropriate template string. 

## Running Tests

To invoke the test suite, you can use the DashKite task runner:

```shell
npx genie test
```

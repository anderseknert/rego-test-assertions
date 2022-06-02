# rego-test-assertions

Tiny [Rego](https://www.openpolicyagent.org/docs/latest/policy-language/) library providing helper
functions for unit testing. The library primarily contains various assertion functions, which will
[print](https://blog.openpolicyagent.org/introducing-the-opa-print-function-809da6a13aee)
the expected result vs. the outcome to the console on failure. This allows you to quickly grasp
what went wrong in your unit tests, resulting in a faster test iteration process!

> This assert library is what I’ve been wanting since I started using OPA.
> Fixed something in ten minutes, while eating a sandwich, I’d previously been poking at for a couple of hours.
> You’ve made my day!

— Duncan Thomas, Groupon

## Usage

Simply download the test assertions library and place it somewhere `opa test` checks for policy
and tests:

```shell
curl -O https://raw.githubusercontent.com/anderseknert/rego-test-assertions/main/test/assert.rego
```

In order to use the test assertion functions, import the `test.assert` package:

```rego
import data.test.assert
```

## Functions

Once imported, all functions may now be referenced like `assert.<function>`. Using the assert package prefix avoids
having these functions clash with other built-ins and custom functions, and makes it clear in your test code what
the purpose of these functions is. As an added bonus, you won't need repeated import statements to import each
function separetely.

| Function                   | Arguments            | Example console output                                   |
|----------------------------|----------------------|----------------------------------------------------------|
| `assert.equals`            | `expected`, `result` | expected equals: "foo" got: "bar"                        |
| `assert.not_equals`        | `expected`, `result` | expected not equals: 1 got: 1                            |
| `assert.all_equals`        | `coll`, `value`      | expected all items to have value 2, failed for [1]       |
| `assert.none_equals`       | `coll`, `value`      | expected no items to have value 2, failed for [2, 2]     |
| `assert.contains`          | `item`, `coll`       | expected string "foo" in array got: ["bar", "baz"]       |
| `assert.not_contains`      | `item`, `coll`       | expected string "foo" not in set got {"foo", "x"}        |
| `assert.empty`             | `coll`               | expected empty set got: {"admin", "dba"}                 |
| `assert.not_empty`         | `coll`               | expected empty array                                     |
| `assert.starts_with`       | `str`, `search`      | expected "test" to start with "a"                        |
| `assert.ends_with`         | `str`, `search`      | expected "test" to end with "a"                          |
| `assert.all_starts_with`   | `coll`, `search`     | expected all strings to start with "a", failed for ["b"] |
| `assert.all_ends_with`     | `coll`, `search`     | expected all strings to end with "a", failed for ["b"]   |
| `assert.none_starts_swith` | `coll`, `search`     | expected no strings to start with "a", failed for ["a"]  |
| `assert.none_ends_swith`   | `coll`, `search`     | expected no strings to end with "a", failed for ["a"]    |
| `assert.fail`              | `msg`                | fail with provided message!                              |

## Example

### Policy

```rego
package rego.example

deny[msg] {
    msg := "I'll always deny that"
}

violation[msg] {
    input.user.name == "banned"
    msg := "You're banned!"
}
```

### Test without assertions

```rego
package rego.example_test

import future.keywords.in

import data.example.deny
import data.example.violation

test_empty_without_assertion {
    count(deny) == 0
}

test_in_without_assertion {
    "You're banned!" in violation with input.user.name as "bob"
}
```

```shell
❯ opa test example_test.rego
example_test.rego:
data.rego.example_test.test_empty_without_assertion: FAIL (178.375µs)
data.rego.example_test.test_in_without_assertion: FAIL (99.416µs)

--------------------------------------------------------------------------------
FAIL: 2/2
```

### Test with assertions

```rego
package rego.example_test

import data.example.deny
import data.example.violation

import data.test.assert

test_empty_with_assertion {
    assert.empty(deny)
}

test_in_with_assertion {
    assert.contains("You're banned!", violation) with input.user.name as "bob"
}
```

```shell
❯ opa test example_test.rego
example_test.rego:
data.rego.example_test.test_empty_with_assertion: FAIL (206.5µs)

  expected empty set got {"I'll always deny that"}

data.rego.example_test.test_in_with_assertion: FAIL (138.792µs)

  expected string "You're banned!" in set got set()

--------------------------------------------------------------------------------
FAIL: 2/2
```

## Prerequisites

OPA v0.39.0 and above — a [bug](https://github.com/open-policy-agent/opa/issues/4489) in older versions caused
the `print` function to error in `else` blocks, which this library makes heavy use of.
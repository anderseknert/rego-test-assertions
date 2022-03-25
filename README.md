# rego-test-assertions

Tiny Rego library with helper functions for unit testing. The library primarily
contains various assertion functions, which will print the expected result vs. the
outcome on failure.

## Functions

| Function            | Arguments            | Example console output                             |
|---------------------|----------------------|----------------------------------------------------|
| `assert_equals`     | `expected`, `result` | expected equals: "foo" got: "bar"                  |
| `assert_not_equals` | `expected`, `result` | expected not equals: 1 got: 1                      |
| `assert_in`         | `item`, `coll`       | expected string "foo" in array got: ["bar", "baz"] |
| `assert_empty`      | `coll`               | expected empty set got: {"admin", "dba"}           |
| `fail`              | `msg`                | fail with provided message!                        |

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

import data.rego.assertions.assert_empty
import data.rego.assertions.assert_in


test_empty_with_assertion {
    assert_empty(deny)
}

test_in_with_assertion {
    assert_in("You're banned!", violation) with input.user.name as "bob"
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
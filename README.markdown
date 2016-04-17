# TDD with RSpec (an introduction)

This exercise has two goals:
 - to introduce you to **TDD** (Test Driven Development)
 - to give an introduction into testing with **rspec**

Do **not** look at the code for now. Just follow the instructions below.


## TDD

The idea of test-driven development (TDD) was made popular by _Kent Beck_ in his 2000 book Extreme Programming Explained. **Extreme Programming (XP)** is a concept containing a variety of different methods to ensure successful projects, quality software (and therefore happy developers). It is the 'father' of _agile_ software development. Testing is only one part of XP, but it is a very central part. Without testing some of the values and practices of XP would not be achievable.

Instead of writing tests for code we already have, we work in a **red-green-refactor cycle**:

* Write the smallest possible test case that matches a requirement.
* Run the test and watch it fail. This gets you into thinking how to write only the code that makes it pass.
* Write some code with the goal of making the test pass.
* Run your test suite. _Repeat steps 3 and 4 until all tests pass._
* Go back and refactor your new code, making it as simple and clear as possible while keeping the test suite green.
* This workflow implies a "step zero": taking time to think carefully about what exactly it is we need to build, and how. When we always start with the implementation, it is easy to lose focus, write unnecessary code, and get stuck.


### BDD

Behavior-driven development (BDD) is a concept built on top of TDD. The idea is to write tests as specifications of system behavior. This is a different way of approaching the same challenge, which should lead us to think more clearly and write tests that are easier to understand and maintain. This in turn should help us write better implementation code.


### RSpec

RSpec is a testing tool for Ruby, created for (BDD). It is the most frequently used testing library for Ruby in production applications. It has a very rich and powerful domain-specific language (DSL). Though this tutorial will hopefully help you get started, assuming you have no prior experience with RSpec or even testing.


### Tests

Good tests are:

- automated
- repeatable
- fast
- covering edge cases


### Committing

While not an explicit part of TDD, BDD, XP or the red-green-refactor cycle, committing your code into your version control system should become a natural part of your workflow.

* commit when the tests are passing / green
* commit after the refactoring step, before writing a new spec which would make the tests fail / red

Commit early and commit often. Many small commits are much easier to understand than a few large ones.

## Setup

Our task will be to create a class that takes text input containing numbers and makes some calculations. We call it StringCalculator. Let's start with the setup, before we come to the full requirements.

1. create a new folder `string_calculator`
2. add a `Gemfile` with this content:

  ```ruby
  source "https://rubygems.org"

  gem "rspec", "~> 3.4"
  ```
3. run `bundle install`
4. add a folder `lib`
5. in the `lib` folder create a new file `string_calculator.rb` with an empty class:

  ```ruby
  class StringCalculator
  end
  ```
6. add a folder `spec`
7. in the `spec` folder create a new file `string_calculator_spec.rb` with this content:

  ```ruby
  require "string_calculator"

  describe StringCalculator do
  end
  ```
8. run `bundle exec rspec spec` to run all tests in the spec folder
9. read the message, it should end with _0 examples, 0 failures_
10. run `git init` to create a new git repository
11. run  `git add .` to add all the files we created to the stage
12. run `git commit -m "Create StringCalculator class and spec"`


## String Calculator

Create a class `StringCalculator` with a class method `.add` that expects one String as input argument.


### The requirements:

* when given an empty string it should return 0
* when given a String with one number in it, it should return this number
* when given a String with two comma separated numbers in it, it should return the sum of those two numbers

Following the idea of TDD, we will write one or more tests for each requirement. _One requirement at the time_, **not** for all requirements at once!

 * **[ red ]** We will first write the test, run it (which should fail).
 * **[ green ]** Then implement _only enough code to make the test pass_.
 * **[ refactor ]** Afterwards we are free to _refactor_ the code (improve the code quality) without adding any new functionality. Run your tests to ensure you did not break previous functionality. Always stay green while refactoring.
 * **[ commit ]** This is not part of TDD. But not only for this exercise it is a good idea to _commit early and commit often_.

----

### The first requirement and test

First we just want to ensure that `StringCalculator.add("")` returns `0`. So we write the first test in `spec/string_calculator_spec.rb`

```ruby
describe StringCalculator do
  describe ".add" do
    context "given an empty string" do
      it "returns zero" do
        expect(StringCalculator.add("")).to eql(0)
      end
    end
  end
end
```

With RSpec, we are always _describing_ the behavior of classes, modules and their methods. The `describe` block is always used at the top to put specs in a context. It can accept either a `ClassName`, in which case the class needs to exist, or any `"string"` you'd like.

We are using another `describe` block to describe the add class method. By convention, class methods are prefixed with a dot `".add"`, and instance methods with a dash `"#add"`.

We are using a `context` block to describe the context under which the add method is expected to return `0`. context is technically the same as describe, but is used in different places, to aid reading of the code.

We are using an `it` block to describe a specific example, which is RSpec's way to say "test case". Generally, every example should be descriptive, and together with the context should form an understandable sentence. This one reads as: _StringCalculator.add: given an empty string, it returns zero_.

`expect(...).to` and the negative variant `expect(...).not_to` are used to define expected outcomes. The Ruby expression they are given (in our case, `StringCalculator.add("")`) is combined with a _matcher_ to fully define an expectation on a piece of code. The matcher we are using here is `eql`, a basic equality matcher. RSpec comes with many more matchers.

**[ red ]** Run `bundle exec rspec spec` and examine the error message. It should tell something about an _undefined method `add' for StringCalculator:Class_

Add the missing class method `add` to `lib/string_calculator.rb` and let it return `0` to make the test pass:

```ruby
class StringCalculator
  def self.add(string)
    0
  end
end
```

**[ green ]** Run `bundle exec rspec spec` to read: _1 example, 0 failures_

> We went from red to green. And we achieved this by writing the simplest possible code to make the test pass. Now it is time for a **[ commit ]**, before we continue!

----

### The second requirement and tests

_When given a String with one number in it, it should return this number_ is the second requirement.

This time we write two tests to ensure the desired behaviour for numbers with one or multiple digits: `spec/string_calculator_spec.rb`

```ruby
describe StringCalculator do
  describe ".add" do
    # [...]

    context "given a single number" do
      context "'4'" do
        it "returns 4" do
          expect(StringCalculator.add("4")).to eql(4)
        end
      end

      context "'10'" do
        it "returns 10" do
          expect(StringCalculator.add("10")).to eql(10)
        end
      end
    end
  end
end
```

**[ red ]** Run `bundle exec rspec spec` and carefully read the error messages.

You should already know what needs to be done to make the test pass. Open `lib/string_calculator.rb` and add the missing functionality:

```ruby
class StringCalculator
  def self.add(string)
    if string == ""
      0
    else
      string.to_i
    end
  end
end
```

**[ green ]** Run `bundle exec rspec spec` to read: _3 examples, 0 failures_

> We went from red to green. But the code is not really beautiful. Let's **[ refactor ]** it!

```ruby
class StringCalculator
  def self.add(string)
    string.to_i
  end
end
```

**[ green ]** Run `bundle exec rspec spec` to read: _3 examples, 0 failures_

> We went from red to green and refactored our code to look better. Now it is time for a **[ commit ]**!

----

### The third requirement and tests

_When given a String with two comma separated numbers in it, it should return the sum of those two numbers_ is the last requirement we will implement.

```ruby
describe StringCalculator do
  describe ".add" do
    # [...]

    context "given two numbers" do
      context "'2,4'" do
        it "returns 6" do
          expect(StringCalculator.add("2,4")).to eql(6)
        end
      end
      context "'17,100'" do
        it "returns 117" do
          expect(StringCalculator.add("17,100")).to eql(117)
        end
      end
    end
  end
end
```

**[ red ]** Run `bundle exec rspec spec` and check your test is working (and failing).

Inspect the output and write enough code to make the test pass.

```ruby
class StringCalculator
  def self.add(string)
    numbers = string.split(",")
    numbers[0].to_i + numbers[1].to_i
  end
end
```

**[ green ]** Run `bundle exec rspec spec` to read: 5 examples, 0 failures

> We went from red to green, is time for a **[ commit ]**!

----

Feel free to add more tests at any time. Additional tests should cover edge cases that your app currently supports (for example white spaces in the input string). This way you can ensure that existing functionality will not be accidentally broken by a new implementation.


## New requirements!

As software is never finished, we just received some new requirements that have to be implemented in the same red-green-refactor cycle as used above.

* when given a String with multiple comma separated numbers (more than two) in it, it should return the sum of all those numbers
* when given a number with decimals, it should make the calculations with decimals and return a number with decimals unless the decimals are all 0

First write the test for the first new requirement, run it, watch it fail and then add the code to make the test pass.

> Depending on your implementation, the new test might already pass. This would mean your StringCalculator already fulfills the requirement. In this case the new test serves as explicit documentation of a previously implicit behaviour of your program.

Rinse and repeat with the second new requirement.


## Bonus: .rspec

RSpec will look for a config file `.rspec` in the project folder you are running it. If it can not be found there, RSpec checks the $HOME folder `~/`

If you want to exchange the default output formatter `progress` that displays one `.` per test with a more verbose formatter, you could create an `~/.rspec` file with this content:

```
--color --format documentation
```

Just run `bundle exec rspec spec` to see the difference!


## Extra bonus: run specific tests

Until now we have been using `bundle exec rspec spec` which runs all the specs in the `spec/` directory.

But it is possible to run only a part of all the specs, by passing the full path to one file:  
`bundle exec rspec spec/string_calculator_spec.rb`

It is even possible to run one specific test, by passing the file name, followed be a colon and the line number:  
`bundle exec rspec spec/string_calculator_spec.rb:14`


## All green and committed

You may now look at the code of the repo (it should be doing the same your code does). To be able to follow the development (and thinking) process I advise you to **read every commit** in order, instead of just reading the end result. This is true for this repo, and also for new features other people add to a project of your's.


## Disclaimer

This README and the code are heavily inspired by the well written RSpec tutorial:
<https://semaphoreci.com/community/tutorials/getting-started-with-rspec>

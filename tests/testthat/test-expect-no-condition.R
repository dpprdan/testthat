
test_that("expect_no_* conditions behave as expected", {

  # base R
  expect_snapshot_failure(expect_no_error(stop("error")))
  expect_snapshot_failure(expect_no_warning(warning("warning")))
  expect_snapshot_failure(expect_no_message(message("message")))

  # rlang equivalents
  expect_snapshot_failure(expect_no_error(abort("error")))
  expect_snapshot_failure(expect_no_warning(warn("warning")))
  expect_snapshot_failure(expect_no_message(inform("message")))
})

test_that("expect_no_* pass with pure code", {
  expect_success(out <- expect_no_error(1))
  expect_equal(out, 1)
  
  expect_success(expect_no_warning(1))
  expect_success(expect_no_message(1))
  expect_success(expect_no_condition(1))
})

test_that("expect_no_* don't emit success when they fail", {
  expect_no_success(expect_no_error(stop("!")))
})

test_that("capture correct trace_env (#1994)", {
  # This should fail, not error
  expect_failure(expect_message({message("a"); warn("b")}) |> expect_no_warning())
  expect_failure(expect_no_message({message("a"); warn("b")}) |> expect_warning())
})

test_that("unmatched conditions bubble up", {
  expect_error(expect_no_error(abort("foo"), message = "bar"), "foo")
  expect_warning(expect_no_warning(warn("foo"), message = "bar"), "foo")
  expect_message(expect_no_message(inform("foo"), message = "bar"), "foo")
  expect_condition(expect_no_condition(signal("foo", "x"), message = "bar"), "foo")
})

test_that("only matches conditions of specified type", {
  foo <- function() {
    warn("This is a problem!", class = "test")
  }
  expect_warning(expect_no_error(foo(), class = "test"), class = "test")
})

test_that("matched conditions give informative message", {
  foo <- function() {
    warn("This is a problem!", class = "test")
  }

  expect_snapshot(error = TRUE, {
    expect_no_warning(foo())
    expect_no_warning(foo(), message = "problem")
    expect_no_warning(foo(), class = "test")
    expect_no_warning(foo(), message = "problem", class = "test")
  })
})

test_that("deprecations always bubble up", {
  foo <- function() {
    lifecycle::deprecate_warn("1.0.0", "foo()")
  }
  expect_warning(
    expect_no_warning(foo()),
    class = "lifecycle_warning_deprecated"
  )
})

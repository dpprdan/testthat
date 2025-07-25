test_that("can locally override edition", {
  local_edition(3)
  expect_equal(edition_get(), 3)

  local_edition(2)
  expect_equal(edition_get(), 2)
})

test_that("checks its inputs", {
  expect_snapshot(error = TRUE, {
    local_edition("x")
    local_edition(5)
  })
})

test_that("deprecation only fired for newer edition", {
  local_edition(2)
  expect_warning(edition_deprecate(3, "old stuff"), NA)

  local_edition(3)
  expect_snapshot(edition_deprecate(3, "old stuff"))
})

test_that("required only fired for older edition", {
  withr::local_options(testthat.edition_ignore = FALSE)
  local_edition(2)
  expect_error(edition_require(3, "new stuff"))

  withr::local_options(testthat.edition_ignore = FALSE)
  local_edition(3)
  expect_error(edition_require(3, "new stuff"), NA)
})

test_that("edition for testthat is 3", {
  expect_equal(find_edition(package = "testthat"), 3)
})

test_that("edition for non-package dir is 2", {
  withr::local_envvar(TESTTHAT_EDITION = NULL)
  expect_equal(find_edition(tempdir()), 2)
})

test_that("can set the edition via an environment variable", {
  local_bindings(edition = zap(), .env = the)
  
  withr::local_envvar(TESTTHAT_EDITION = 2)
  expect_equal(edition_get(), 2)

  withr::local_envvar(TESTTHAT_EDITION = 3)
  expect_equal(edition_get(), 3)
})

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/expect-constant.R
\name{logical-expectations}
\alias{logical-expectations}
\alias{expect_true}
\alias{expect_false}
\title{Does code return \code{TRUE} or \code{FALSE}?}
\usage{
expect_true(object, info = NULL, label = NULL)

expect_false(object, info = NULL, label = NULL)
}
\arguments{
\item{object}{Object to test.

Supports limited unquoting to make it easier to generate readable failures
within a function or for loop. See \link{quasi_label} for more details.}

\item{info}{Extra information to be included in the message. This argument
is soft-deprecated and should not be used in new code. Instead see
alternatives in \link{quasi_label}.}

\item{label}{Used to customise failure messages. For expert use only.}
}
\description{
These are fall-back expectations that you can use when none of the other
more specific expectations apply. The disadvantage is that you may get
a less informative error message.

Attributes are ignored.
}
\examples{
expect_true(2 == 2)
# Failed expectations will throw an error
\dontrun{
expect_true(2 != 2)
}
expect_true(!(2 != 2))
# or better:
expect_false(2 != 2)

a <- 1:3
expect_true(length(a) == 3)
# but better to use more specific expectation, if available
expect_equal(length(a), 3)
}
\seealso{
\code{\link[=is_false]{is_false()}} for complement

Other expectations: 
\code{\link{comparison-expectations}},
\code{\link{equality-expectations}},
\code{\link{expect_error}()},
\code{\link{expect_length}()},
\code{\link{expect_match}()},
\code{\link{expect_named}()},
\code{\link{expect_null}()},
\code{\link{expect_output}()},
\code{\link{expect_reference}()},
\code{\link{expect_shape}()},
\code{\link{expect_silent}()},
\code{\link{inheritance-expectations}}
}
\concept{expectations}

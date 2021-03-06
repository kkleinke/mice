\name{squeeze}
\alias{squeeze}
\title{Squeeze the imputed values to be within specified boundaries.}
\usage{
  squeeze(x, bounds = c(min(x[r]), max(x[r])),
    r = rep(TRUE, length(x)))
}
\arguments{
  \item{x}{A numerical vector with values}

  \item{bounds}{A numerical vector of length 2 containing
  the lower and upper bounds. By default, the bounds are to
  the minimum and maximum values in \code{x}.}

  \item{r}{A logical vector of length \code{length(x)} that
  is used to select a subset in \code{x} before calculating
  automatic bounds.}
}
\value{
  A vector of length \code{length(x)}.
}
\description{
  This function replaces any values in \code{x} that are
  lower than \code{bounds[1]} by \code{bounds[1]}, and
  replaces any values higher than \code{bounds[2]} by
  \code{bounds[2]}.
}
\author{
  Stef van Buuren, 2011.
}


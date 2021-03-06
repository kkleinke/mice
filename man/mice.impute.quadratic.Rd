\name{mice.impute.quadratic}
\alias{mice.impute.quadratic}
\alias{quadratic}
\title{Imputation of quadratric terms}
\usage{
  mice.impute.quadratic(y, ry, x, ...)
}
\arguments{
  \item{y}{Incomplete data vector of length \code{n}}

  \item{ry}{Vector of missing data pattern
  (\code{FALSE}=missing, \code{TRUE}=observed)}

  \item{x}{Matrix (\code{n} x \code{p}) of complete
  covariates.}

  \item{...}{Other named arguments.}
}
\value{
  A vector of length \code{nmis} with imputations.
}
\description{
  Imputes univariate missing data of incomplete variable
  that appears as both main effect and quadratic effect in
  the complete-data model.
}
\details{
  This implements polynomial combination method. First, the
  polynomial combination $Z = Y beta_1 + Y^2 beta_2$ is
  formed. $Z$ is imputed by predictive mean matching,
  followed by a decomposition of the imputed data $Z$ into
  components $Y$ and $Y^2$.  See Van Buuren (2012, pp.
  139-141) and Vink et al (2012) for more details. The
  method ensures that 1) the imputed data for $Y$ and $Y^2$
  are mutually consistent, and 2) that provides unbiased
  estimates of the regression weights in a complete-data
  linear regression that use both $Y$ and $Y^2$.
}
\note{
  There are two situations to consider. If only the linear
  term \code{Y} is present in the data, calculate the
  quadratic term \code{YY} after imputation. If both the
  linear term \code{Y} and the the quadratic term \code{YY}
  are variables in the data, then first impute \code{Y} by
  calling \code{mice.impute.quadratic()} on \code{Y}, and
  then impute \code{YY} by passive imputation as
  \code{meth["YY"] <- "~I(Y^2)"}.  See example section for
  details.  Generally, we would like \code{YY} to be
  present in the data if we need to preserve quadratic
  relations between \code{YY} and any third variables in
  the multivariate incomplete data that we might wish to
  impute.
}
\examples{
require(lattice)

# Create Data
B1=.5
B2=.5
X<-rnorm(1000)
XX<-X^2
e<-rnorm(1000, 0, 1)
Y <- B1*X+B2*XX+e
dat <- data.frame(x=X, xx=XX, y=Y)

# Impose 25 percent MCAR Missingness
dat[0 == rbinom(1000, 1, 1-.25), 1:2] <- NA

# Prepare data for imputation
ini <- mice(dat, maxit=0)
meth <- c("quadratic", "~I(x^2)", "")
pred <- ini$pred
pred[,"xx"] <- 0

# Impute data
imp <- mice(dat, meth=meth, pred=pred)

# Pool results
pool(with(imp, lm(y~x+xx)))

# Plot results
stripplot(imp)
plot(dat$x, dat$xx, col="blue", xlab="x", ylab="xx")
points(complete(imp,1)$x[is.na(dat$x)], complete(imp,1)$xx[is.na(dat$x)], col="red")
}
\author{
  Gerko Vink (University of Utrecht), \email{g.vink@uu.nl}
}
\references{
  van Buuren, S. (2012). \emph{Flexible Imputation of
  Missing Data.} Boca Raton, FL: Chapman & Hall/CRC Press.

  Vink, G., Frank, L.E., van Buuren, S. (2012). Multiple
  Imputation of Squares. \emph{Sociological Methods &
  Research}, accepted for publication.
}
\seealso{
  \code{\link{mice.impute.pmm}}
}
\keyword{datagen}


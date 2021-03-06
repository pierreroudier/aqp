% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/glom.R
\name{glom,SoilProfileCollection-method}
\alias{glom,SoilProfileCollection-method}
\alias{glom}
\title{Subset soil horizon data using a depth or depth interval}
\usage{
\S4method{glom}{SoilProfileCollection}(
  p,
  z1,
  z2 = NULL,
  ids = FALSE,
  df = FALSE,
  truncate = FALSE,
  invert = FALSE,
  modality = "all"
)
}
\arguments{
\item{p}{A SoilProfileCollection}

\item{z1}{Top depth (required) - depth to intersect horizon; if 'z2' specified, top depth of intersection interval.}

\item{z2}{optional: bottom depth of intersection interval}

\item{ids}{Return only horizon IDs? default: \code{FALSE}}

\item{df}{Return a data.frame, by intersection with \code{horizons(p)}? default: \code{FALSE}}

\item{truncate}{Truncate horizon top and bottom depths to \code{z1} and \code{z2}? default: \code{FALSE}}

\item{invert}{Get the horizons ranges outside the interval z1/z2? default: \code{FALSE}}

\item{modality}{Return all horizons (default: \code{"all"}) or first, \emph{thickest} (\code{modality = "thickest"}) horizon in interval.}
}
\value{
A SoilProfileCollection, data.frame, or a vector of horizon IDs. \code{NULL} if no result.
}
\description{
\code{glom()} returns a "clod" of horizons from a SoilProfileCollection from a depth interval.

All horizons included within the specified interval are returned in their entirety (not just the portion within the interval), unless the \code{truncate} argument is specified. Horizon intersection is based on unique ID \code{hzidname(spc)} and attribute of interest.

If intersection at the specified boundaries \code{['z1', 'z2']} results in no horizon data, 'NULL' is returned with a warning containing the offending pedon ID.

If inverting results with \code{invert}, it is possible that thick horizons (that span more than the entire glom interval) will be split into two horizons. This may make the results from \code{ids = TRUE} different from what you expect, as they will be based on a profile with an "extra" horizon.
}
\details{
The verb/function that creates a clod is "glom". "To glom" is "to steal" or to "become stuck or attached to". The word is related to the compound "glomalin", which is a glycoprotein produced by mycorrhizal fungi in soil.
}
\examples{
data(sp1, package = 'aqp')
depths(sp1) <- id ~ top + bottom
site(sp1) <- ~ group

p <- sp1[1]

foo <- glom(p, 25, 100)

# there are 4 horizons in the clod glommed from depths 25 to 100 on profile 1 in sp1
nrow(foo)
}
\seealso{
\code{\link{glomApply}} \code{\link{trunc}}
}
\author{
Andrew G. Brown
}

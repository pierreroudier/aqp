% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/mutate_profile.R
\name{mutate_profile}
\alias{mutate_profile}
\alias{mutate_profile,SoilProfileCollection-method}
\title{Transform a SPC (by profile) with a set of expressions}
\arguments{
\item{object}{A SoilProfileCollection}

\item{...}{A set of comma-delimited R expressions that resolve to a transformation to be applied to a single profile e.g \code{mutate_profile(hzdept = max(hzdept) - hzdept)}}
}
\value{
A SoilProfileCollection.
}
\description{
\code{mutate_profile()} is a function used for transforming SoilProfileCollections. Each expression is applied to site or horizon level attributes of individual profiles. This distinguishes this function from \code{mutate}, which is applied to pooled values (across individuals) in a collection/group.
}
\author{
Andrew G. Brown.
}

% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PMS2Munsell.R
\name{PMS2Munsell}
\alias{PMS2Munsell}
\title{Convert Pantone PMS codes to Munsell notation}
\usage{
PMS2Munsell(codes)
}
\arguments{
\item{codes}{vector of PMS codes (e.g. '7630-c'), may contain NA, see \code{\link{pms.munsell.lut}}}
}
\value{
\code{data.frame} containing closest associated Munsell color (via \code{rgb2munsell}), hex notation, and perceptual color distance (dE00) between sRGB values and closest Munsell "chip".
}
\description{
Convert Pantone PMS codes to Munsell notation
}
\details{
Conversion of \href{https://en.wikipedia.org/wiki/Pantone}{Pantone spot colors} (PMS code) is performed by look-up from \code{\link{pms.munsell.lut}}. Association is based on the "closest" Munsell color via \href{https://en.wikipedia.org/wiki/Color_difference#CIEDE2000}{CIE2000 distance metric (dE00)} (see \code{\link{rgb2munsell}}). This is an experimental association between the two color systems and should not be used for precision color matching or paint mixing applications.

Possible uses include rough estimation of soil colors in the field, by means of color swatches based on the Pantone system. This type of color matching is most appropriate in an educational setting where official soil color books may be too expensive.
}
\note{
Inspired by the work and outreach efforts of Dr. Karen Vaughan (UWY).
}
\examples{

# safely handles NA
codes <- c(NA, "7630-c", "102-c")

PMS2Munsell(codes)

}
\author{
D.E. Beaudette
}

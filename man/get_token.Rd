% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/log.R
\name{get_token}
\alias{get_token}
\title{Get a token}
\usage{
get_token(
  url,
  user = rstudioapi::showPrompt("User", "Your username"),
  password = rstudioapi::askForPassword()
)
}
\arguments{
\item{url}{url}

\item{user}{username}

\item{password}{password}
}
\description{
Get a token
}

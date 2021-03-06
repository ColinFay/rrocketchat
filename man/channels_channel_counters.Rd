% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/channels_channel_counters.R
\name{channels_channel_counters}
\alias{channels_channel_counters}
\title{Channel Counters}
\usage{
channels_channel_counters(tok, roomid, roomname, userid = NULL)
}
\arguments{
\item{roomid}{The channel’s id Required}

\item{roomname}{The channel’s name Required}

\item{userid}{Counters for provided user id (need to have a view-room-administration right for calling user) Optional}

\item{token}{The token to connect to the app.}
}
\description{
Gets channel counters.
}

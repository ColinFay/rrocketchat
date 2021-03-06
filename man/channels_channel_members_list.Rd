% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/channels_channel_members_list.R
\name{channels_channel_members_list}
\alias{channels_channel_members_list}
\title{Channel Members List}
\usage{
channels_channel_members_list(tok, roomid, roomname)
}
\arguments{
\item{roomid}{The channel’s id Required (if no roomName)}

\item{roomname}{The channel’s name Required (if no roomId)}

\item{token}{The token to connect to the app.}
}
\description{
Lists all channel users. It supports the Offset, Count, and Sort Query Parameters.
}

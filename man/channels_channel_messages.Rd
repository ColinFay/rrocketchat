% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/channels_channel_messages.R
\name{channels_channel_messages}
\alias{channels_channel_messages}
\title{Channel messages}
\usage{
channels_channel_messages(tok, roomid, roomname)
}
\arguments{
\item{roomid}{The channel’s id Required(if no roomName}

\item{roomname}{The channel’s name Required(if no roomId)}

\item{token}{The token to connect to the app.}
}
\description{
Lists all of the specific channel messages on the server. It supports the Offset, Count, and Sort Query Parameters along with Query and Fields Query Parameters.
}

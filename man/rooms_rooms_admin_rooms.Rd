% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/rooms_rooms_admin_rooms.R
\name{rooms_rooms_admin_rooms}
\alias{rooms_rooms_admin_rooms}
\title{Rooms Admin Rooms}
\usage{
rooms_rooms_admin_rooms(tok, types = NULL, filter = NULL)
}
\arguments{
\item{types}{The rooms types Optional (must be an array)}

\item{filter}{The rooms’s name Optional}

\item{token}{The token to connect to the app.}
}
\description{
Retrieves all rooms (requires the view-room-administration permission). It supports the Offset, Count, and Sort Query Parameters.
}

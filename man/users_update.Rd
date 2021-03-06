% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/users_update.R
\name{users_update}
\alias{users_update}
\title{Update}
\usage{
users_update(
  tok,
  userid,
  data_email = NULL,
  data_name = NULL,
  data_password = NULL,
  data_username = NULL,
  data_active = NULL,
  data_roles = NULL,
  data_joindefaultchannels = NULL,
  data_requirepasswordchange = NULL,
  data_sendwelcomeemail = NULL,
  data_verified = NULL,
  data_customfields = NULL
)
}
\arguments{
\item{userid}{The id of the user to update. Required}

\item{data_email}{The email address for the user. Optional}

\item{data_name}{The display name of the user. Optional}

\item{data_password}{The password for the user. Optional}

\item{data_username}{The username for the user. Optional}

\item{data_active}{Whether the user is active, which determines if they can login or not. Optional  Default: true}

\item{data_roles}{The roles the user has assigned to them. Optional  Default: ['user']}

\item{data_joindefaultchannels}{Whether the user should join the default channels. Optional  Default: true}

\item{data_requirepasswordchange}{Should the user be required to change their password when they login? Optional  Default: false}

\item{data_sendwelcomeemail}{Should the user get a welcome email? Optional  Default: false}

\item{data_verified}{Should the user’s email address be verified? Optional  Default: false}

\item{data_customfields}{Any custom fields the user should have on their account. Optional  Default: undefined}

\item{token}{The token to connect to the app.}
}
\description{
Note
}

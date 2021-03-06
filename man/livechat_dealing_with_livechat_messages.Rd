% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/livechat_dealing_with_livechat_messages.R
\name{livechat_dealing_with_livechat_messages}
\alias{livechat_dealing_with_livechat_messages}
\title{Dealing with Livechat messages}
\usage{
livechat_dealing_with_livechat_messages(
  tok,
  token,
  rid,
  msg,
  x_id = NULL,
  agent = NULL
)
}
\arguments{
\item{token}{Visitor token. Required}

\item{rid}{Room _id. Required}

\item{msg}{Message text. Required}

\item{x_id}{Message _id. Optional}

\item{agent}{Room agent. Optional}
}
\description{
Send a new Livechat message
}

#' Get Presence
#'
#' Gets a user’s presence if the query string userId or username is provided, otherwise it gets the callee’s.
#'
#' @param token The token to connect to the app.
#' @param userid_or_username The id or username of the user. If not provided, the auth user is updated. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
users_get_presence <- function(tok,
                               userid_or_username = NULL) {
  params <- list(
    userid_or_username = userid_or_username
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.getPresence")
  )

  stop_for_status(res)
  content(res)
}

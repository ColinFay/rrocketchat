#' Users Presence
#'
#' Gets all connected users presence.
#'
#' @param token The token to connect to the app.
#' @param from The last date you got a status change Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
users_users_presence <- function(tok,
                                 from = NULL) {
  params <- list(
    from = from
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.presence")
  )

  stop_for_status(res)
  content(res)
}

#' Info
#'
#' Retrieves information about a user, the result is only limited to what the callee has access to view.. It supports  Fields Query Parameter with the userRooms field, that returns the rooms that the user is part of.
#'
#' @param token The token to connect to the app.
#' @param userid_or_username The id or username of the user. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
users_info <- function(tok,
                       userid_or_username) {
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
    url = paste0(tok$url, "/api/v1/users.info")
  )

  stop_for_status(res)
  content(res)
}

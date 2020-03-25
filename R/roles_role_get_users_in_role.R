#' Role Get Users In Role
#'
#' Gets the users that belongs to a role. It supports the Offset and Count Only.
#'
#' @param token The token to connect to the app.
#' @param role The role. Required
#' @param roomid The room’s id. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
roles_role_get_users_in_role <- function(tok,
                                         role,
                                         roomid = NULL) {
  params <- list(
    role = role,
    roomid = roomid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/roles.getUsersInRole")
  )

  stop_for_status(res)
  content(res)
}

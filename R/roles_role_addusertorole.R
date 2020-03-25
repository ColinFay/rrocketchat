#' Role AddUserToRole
#'
#' Assign a role to an user. Optionally, you can set this role to a room.
#'
#' @param token The token to connect to the app.
#' @param rolename The role name. Required
#' @param username The user name. Required
#' @param roomid If the role scope be Subscriptions and assign it to a room, you need to pass the roomId as parameter. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
roles_role_addusertorole <- function(tok,
                                     rolename,
                                     username,
                                     roomid = NULL) {
  params <- list(
    rolename = rolename,
    username = username,
    roomid = roomid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/roles.addUserToRole"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

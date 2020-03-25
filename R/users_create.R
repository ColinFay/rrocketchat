#' Create
#'
#' Create a new user. Requires create-user permission.
#'
#' @param token The token to connect to the app.
#' @param email The email address for the user. Required
#' @param name The display name of the user. Required
#' @param password The password for the user. Required
#' @param username The username for the user. Required
#' @param active Whether the user is active, which determines if they can login or not. Optional  Default: true
#' @param roles The roles the user has assigned to them on creation. Optional  Default: ['user']
#' @param joindefaultchannels Whether the user should join the default channels when created. Optional  Default: true
#' @param requirepasswordchange Should the user be required to change their password when they login? Optional  Default: false
#' @param sendwelcomeemail Should the user get a welcome email? Optional  Default: false
#' @param verified Should the user’s email address be verified when created? Optional  Default: false
#' @param customfields Any custom fields the user should have on their account. Optional  Default: undefined
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
users_create <- function(tok,
                         email,
                         name,
                         password,
                         username,
                         active = NULL,
                         roles = NULL,
                         joindefaultchannels = NULL,
                         requirepasswordchange = NULL,
                         sendwelcomeemail = NULL,
                         verified = NULL,
                         customfields = NULL) {
  params <- list(
    email = email,
    name = name,
    password = password,
    username = username,
    active = active,
    roles = roles,
    joindefaultchannels = joindefaultchannels,
    requirepasswordchange = requirepasswordchange,
    sendwelcomeemail = sendwelcomeemail,
    verified = verified,
    customfields = customfields
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.create"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

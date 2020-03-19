#' Update
#'
#' Note
#'
#' @param token The token to connect to the app.
#' @param userid The id of the user to update. Required
#' @param data_email The email address for the user. Optional
#' @param data_name The display name of the user. Optional
#' @param data_password The password for the user. Optional
#' @param data_username The username for the user. Optional
#' @param data_active Whether the user is active, which determines if they can login or not. Optional  Default: true
#' @param data_roles The roles the user has assigned to them. Optional  Default: ['user']
#' @param data_joindefaultchannels Whether the user should join the default channels. Optional  Default: true
#' @param data_requirepasswordchange Should the user be required to change their password when they login? Optional  Default: false
#' @param data_sendwelcomeemail Should the user get a welcome email? Optional  Default: false
#' @param data_verified Should the user’s email address be verified? Optional  Default: false
#' @param data_customfields Any custom fields the user should have on their account. Optional  Default: undefined
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
user_update <- function(tok,
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
                   data_customfields = NULL) {
  params <- list(
    userid = userid,
    data_email = data_email,
    data_name = data_name,
    data_password = data_password,
    data_username = data_username,
    data_active = data_active,
    data_roles = data_roles,
    data_joindefaultchannels = data_joindefaultchannels,
    data_requirepasswordchange = data_requirepasswordchange,
    data_sendwelcomeemail = data_sendwelcomeemail,
    data_verified = data_verified,
    data_customfields = data_customfields
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.update"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

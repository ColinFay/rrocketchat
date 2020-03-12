#' Update own basic information
#'
#' Note that to update the password or email for the user you must send currentPassword property encrypted in SHA256 together in payload.
#'
#' @param token The token to connect to the app.
#' @param data_email The email address for the user. Optional
#' @param data_name The display name of the user. Optional
#' @param data_username The username for the user. Optional
#' @param data_currentpassword The password for the user encrypted in SHA256. Optional
#' @param data_newpassword The new password for the user Optional
#' @param data_customfields Any custom fields the user should have on their account. Optional  Default: undefined
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
update_own_basic_information <- function(tok,
                                         data_email = NULL,
                                         data_name = NULL,
                                         data_username = NULL,
                                         data_currentpassword = NULL,
                                         data_newpassword = NULL,
                                         data_customfields = NULL) {
  params <- list(
    data_email = data_email,
    data_name = data_name,
    data_username = data_username,
    data_currentpassword = data_currentpassword,
    data_newpassword = data_newpassword,
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
    url = paste0(tok$url, "/api/v1/users.updateOwnBasicInfo"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

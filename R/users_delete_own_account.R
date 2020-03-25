#' Delete Own Account
#'
#' Deletes your own user. Requires Allow Users to Delete Own Account enabled. Accessible from Administration -> Accounts.
#'
#' @param token The token to connect to the app.
#' @param password The password of user (encrypted in SHA256). Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
users_delete_own_account <- function(tok,
                                     password) {
  params <- list(
    password = password
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.deleteOwnAccount"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

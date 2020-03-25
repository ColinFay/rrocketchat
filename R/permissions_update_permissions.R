#' Update Permissions
#'
#' Edits permissions on the server.
#'
#' @param token The token to connect to the app.
#' @param permissions The array of roles to overwrite. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
permissions_update_permissions <- function(tok,
                                           permissions) {
  params <- list(
    permissions = permissions
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/permissions.update"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

#' Set Active Status
#'
#' @param token The token to connect to the app.
#' @param activestatus The value of the active status. Required
#' @param userid The user’s id to be changed. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
users_set_active_status <- function(tok,
                                    activestatus,
                                    userid) {
  params <- list(
    activestatus = activestatus,
    userid = userid
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.setActiveStatus"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

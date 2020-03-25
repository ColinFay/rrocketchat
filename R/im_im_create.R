#' IM Create
#'
#' Create a direct message session with another user.
#'
#' @param token The token to connect to the app.
#' @param username The username to open a direct message session Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
im_im_create <- function(tok,
                         username) {
  params <- list(
    username = username
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/im.create"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

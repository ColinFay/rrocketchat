#' Settings Get
#'
#' Gets the setting for the provided _id.
#'
#' @param token The token to connect to the app.
#' @param x_id The setting’s _id field Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
settings_settings_get <- function(tok,
                                  x_id) {
  params <- list(
    x_id = x_id
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/settings/:_id")
  )

  stop_for_status(res)
  content(res)
}

#' Settings Update
#'
#' Updates the setting for the provided _id.
#'
#' @param token The token to connect to the app.
#' @param x_id The setting’s _id field Required
#' @param value The value to update the setting. Required
#' @param color The color code to update the setting. Optional
#' @param editor The editor key, with color value. Required if color was set
#' @param execute To trigger a action-button Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
settings_settings_update <- function(tok,
                                     x_id,
                                     value,
                                     color = NULL,
                                     editor,
                                     execute = NULL) {
  params <- list(
    x_id = x_id,
    value = value,
    color = color,
    editor = editor,
    execute = execute
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/settings/:_id"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

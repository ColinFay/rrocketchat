#' Shield SVG
#'
#' A simple method, requires no authentication, that returns the shield svg(badge) to add in your website. It must have API_Enable_Shields enabled.
#'
#' @param token The token to connect to the app.
#' @param type Can be one of online, user, channel Optional
#' @param icon  Optional
#' @param channel Name of the channel Optional
#' @param name Name to show Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
miscellaneous_shield_svg <- function(tok,
                                     type = NULL,
                                     icon = NULL,
                                     channel = NULL,
                                     name = NULL) {
  params <- list(
    type = type,
    icon = icon,
    channel = channel,
    name = name
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/shield.svg")
  )

  stop_for_status(res)
  content(res)
}

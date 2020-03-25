#' Group Set Topic
#'
#' Sets the topic for the private group.
#'
#' @param token The token to connect to the app.
#' @param roomid The private group’s id Required
#' @param topic The private group’s topic to set. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
groups_group_set_topic <- function(tok,
                                   roomid,
                                   topic) {
  params <- list(
    roomid = roomid,
    topic = topic
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/groups.setTopic"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

#' IM Set Topic
#'
#' Sets the topic for the direct message.
#'
#' @param token The token to connect to the app.
#' @param roomid The direct message id Required
#' @param topic The direct message topic to set. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
im_im_set_topic <- function(tok,
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
    url = paste0(tok$url, "/api/v1/im.setTopic"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

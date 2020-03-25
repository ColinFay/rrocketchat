#' Search for messages in a channel
#'
#' Search for messages in a channel by id and text message.
#'
#' @param token The token to connect to the app.
#' @param roomid The id of the channel. Required
#' @param searchtext The text message to search in messages. Required
#' @param count The limit of result. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
chat_search_for_messages_in_a_channel <- function(tok,
                                                  roomid,
                                                  searchtext,
                                                  count = NULL) {
  params <- list(
    roomid = roomid,
    searchtext = searchtext,
    count = count
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/chat.search")
  )

  stop_for_status(res)
  content(res)
}

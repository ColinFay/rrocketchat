#' Read
#'
#' Mark messages as unread by roomId or from a message.. NOTE: You can send roomId or the id of the message (firstUnreadMessage._id) you want from it to be unread.
#'
#' @param token The token to connect to the app.
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
read <- function(tok) {
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/subscriptions.unread"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

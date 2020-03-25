#' Dealing with Livechat messages
#'
#' Send a new Livechat message
#'
#' @param token The token to connect to the app.
#' @param token Visitor token. Required
#' @param rid Room _id. Required
#' @param msg Message text. Required
#' @param x_id Message _id. Optional
#' @param agent Room agent. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
livechat_dealing_with_livechat_messages <- function(tok,
                                                    token,
                                                    rid,
                                                    msg,
                                                    x_id = NULL,
                                                    agent = NULL) {
  params <- list(
    token = token,
    rid = rid,
    msg = msg,
    x_id = x_id,
    agent = agent
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/livechat/message"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

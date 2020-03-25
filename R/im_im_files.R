#' Im Files
#'
#' Retrieves the files from a direct message. It supports the Offset, Count, and Sort Query Parameters along with Query and Fields Query Parameters.
#'
#' @param token The token to connect to the app.
#' @param roomid_username The room id.  The user name. Required
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
im_im_files <- function(tok,
                        roomid_username) {
  params <- list(
    roomid_username = roomid_username
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::GET(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/im.files")
  )

  stop_for_status(res)
  content(res)
}

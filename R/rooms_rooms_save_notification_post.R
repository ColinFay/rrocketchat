#' Rooms save notification POST
#'
#' Sets the notifications settings of specific channel.
#'
#' @param token The token to connect to the app.
#' @param roomid The channel’s id Required
#' @param notifications_desktopnotifications The value for desktop notifications Optional: ‘nothing’, ‘all’, ‘mentions’, ‘default’
#' @param notifications_disablenotifications The value to disable/enable channel’s notifications. Optional: ‘0’ or ‘1’
#' @param notifications_emailnotifications The value for email notifications. Optional: ‘nothing’, ‘all’, ‘mentions’, ‘default’
#' @param notifications_audionotifications The value for audio notifications. Optional: ‘nothing’, ‘all’, ‘mentions’, ‘default’
#' @param notifications_mobilepushnotifications The value for mobile push notifications. Optional: ‘nothing’, ‘all’, ‘mentions’, ‘default’
#' @param notifications_audionotificationvalue The value for audio notification sound. Optional
#' @param notifications_desktopnotificationduration The value for desktop notification duration. Optional
#' @param notifications_unreadalert The value for unread alerts notifications. Optional: ‘nothing’, ‘all’, ‘mentions’, ‘default’
#' @param notifications_hideunreadstatus The value to disable/enable number of unread messages. Optional: ‘0’ or ‘1’
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
rooms_rooms_save_notification_post <- function(tok,
                                               roomid,
                                               notifications_desktopnotifications = NULL,
                                               notifications_disablenotifications = NULL,
                                               notifications_emailnotifications = NULL,
                                               notifications_audionotifications = NULL,
                                               notifications_mobilepushnotifications = NULL,
                                               notifications_audionotificationvalue = NULL,
                                               notifications_desktopnotificationduration = NULL,
                                               notifications_unreadalert = NULL,
                                               notifications_hideunreadstatus = NULL) {
  params <- list(
    roomid = roomid,
    notifications_desktopnotifications = notifications_desktopnotifications,
    notifications_disablenotifications = notifications_disablenotifications,
    notifications_emailnotifications = notifications_emailnotifications,
    notifications_audionotifications = notifications_audionotifications,
    notifications_mobilepushnotifications = notifications_mobilepushnotifications,
    notifications_audionotificationvalue = notifications_audionotificationvalue,
    notifications_desktopnotificationduration = notifications_desktopnotificationduration,
    notifications_unreadalert = notifications_unreadalert,
    notifications_hideunreadstatus = notifications_hideunreadstatus
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/rooms.saveNotification"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

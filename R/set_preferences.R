#' Set Preferences
#'
#' @param token The token to connect to the app.
#' @param userid The id of the user. Required
#' @param data_newroomnotification New room notification. Required
#' @param data_newmessagenotification New message notification. Required
#' @param data_useemojis User can use emojis. Required
#' @param data_convertasciiemoji Convert ascII emojis. Required
#' @param data_savemobilebandwidth Save mobile bandwidth. Required
#' @param data_collapsemediabydefault Collapse media by default. Required
#' @param data_autoimageload Image load automatically. Required
#' @param data_emailnotificationmode Email notification mode. Required
#' @param data_roomslistexhibitionmode Rooms list exhibition mode. Required
#' @param data_unreadalert Unread Alert. Required
#' @param data_notificationssoundvolume Volume of notification sound. Required
#' @param data_desktopnotifications Desktop notifications. Required
#' @param data_mobilenotifications Mobile notifications. Required
#' @param data_enableautoaway Enable auto away. Required
#' @param data_highlights Highlights. Required
#' @param data_desktopnotificationduration Duration of desktop notification. Required
#' @param data_desktopnotificationrequireinteraction Determines if user has to click on desktop notification to close it (requires Google Chrome version > 50 as client, overwrites setting desktopNotificationDuration). Required
#' @param data_viewmode View mode. Required
#' @param data_hideusernames Hide usernames. Required
#' @param data_hideroles Hide user roles. Required
#' @param data_hideavatars Hide avatars. Required
#' @param data_sendonenter Send message on enter. Required
#' @param data_roomcountersidebar Display room counter on sidebar. Required
#' @param data_language Language. Required
#' @param data_sidebarshowfavorites Show favorites on sidebar. Optional
#' @param data_sidebarshowunread Show unread on sidebar. Optional
#' @param data_sidebarsortby Show sort by. Optional
#' @param data_sidebarviewmode Show view mode. Optional
#' @param data_sidebarhideavatar Show avatar on hide bar. Optional
#' @param data_groupbytype Group channels by type. Optional
#' @param data_mutefocusedconversations Mute focused conversations. Optional
#'
#' @export
#' @importFrom httr POST GET add_headers content stop_for_status
#' @importFrom jsonlite toJSON
set_preferences <- function(tok,
                            userid,
                            data_newroomnotification,
                            data_newmessagenotification,
                            data_useemojis,
                            data_convertasciiemoji,
                            data_savemobilebandwidth,
                            data_collapsemediabydefault,
                            data_autoimageload,
                            data_emailnotificationmode,
                            data_roomslistexhibitionmode,
                            data_unreadalert,
                            data_notificationssoundvolume,
                            data_desktopnotifications,
                            data_mobilenotifications,
                            data_enableautoaway,
                            data_highlights,
                            data_desktopnotificationduration,
                            data_desktopnotificationrequireinteraction,
                            data_viewmode,
                            data_hideusernames,
                            data_hideroles,
                            data_hideavatars,
                            data_sendonenter,
                            data_roomcountersidebar,
                            data_language,
                            data_sidebarshowfavorites = NULL,
                            data_sidebarshowunread = NULL,
                            data_sidebarsortby = NULL,
                            data_sidebarviewmode = NULL,
                            data_sidebarhideavatar = NULL,
                            data_groupbytype = NULL,
                            data_mutefocusedconversations = NULL) {
  params <- list(
    userid = userid,
    data_newroomnotification = data_newroomnotification,
    data_newmessagenotification = data_newmessagenotification,
    data_useemojis = data_useemojis,
    data_convertasciiemoji = data_convertasciiemoji,
    data_savemobilebandwidth = data_savemobilebandwidth,
    data_collapsemediabydefault = data_collapsemediabydefault,
    data_autoimageload = data_autoimageload,
    data_emailnotificationmode = data_emailnotificationmode,
    data_roomslistexhibitionmode = data_roomslistexhibitionmode,
    data_unreadalert = data_unreadalert,
    data_notificationssoundvolume = data_notificationssoundvolume,
    data_desktopnotifications = data_desktopnotifications,
    data_mobilenotifications = data_mobilenotifications,
    data_enableautoaway = data_enableautoaway,
    data_highlights = data_highlights,
    data_desktopnotificationduration = data_desktopnotificationduration,
    data_desktopnotificationrequireinteraction = data_desktopnotificationrequireinteraction,
    data_viewmode = data_viewmode,
    data_hideusernames = data_hideusernames,
    data_hideroles = data_hideroles,
    data_hideavatars = data_hideavatars,
    data_sendonenter = data_sendonenter,
    data_roomcountersidebar = data_roomcountersidebar,
    data_language = data_language,
    data_sidebarshowfavorites = data_sidebarshowfavorites,
    data_sidebarshowunread = data_sidebarshowunread,
    data_sidebarsortby = data_sidebarsortby,
    data_sidebarviewmode = data_sidebarviewmode,
    data_sidebarhideavatar = data_sidebarhideavatar,
    data_groupbytype = data_groupbytype,
    data_mutefocusedconversations = data_mutefocusedconversations
  )

  params <- no_null(params)

  params <- toJSON(params, auto_unbox = TRUE)
  res <- httr::POST(
    add_headers(
      "Content-type" = "application/json",
      "X-Auth-Token" = tok$data$authToken,
      "X-User-Id" = tok$data$userId
    ),
    url = paste0(tok$url, "/api/v1/users.setPreferences"),
    body = params
  )

  stop_for_status(res)
  content(res)
}

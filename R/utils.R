no_null <- function(list) {
  list[
    ! sapply(list, function(x) is.null(x))
    ]
}

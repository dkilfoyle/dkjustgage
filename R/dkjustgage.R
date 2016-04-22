#' HTMLWidget wrapper for justgage
#'
#' Radial gage widget
#'
#' @param value Gage value
#' @param min,max Gage limits
#' @param label Text label below the gage eg units
#' @param title Title above gage
#' @param reverse True to reverse color gradient
#' @param symbol Postfix a symbol to the value label eg \code{'\%'}
#' @param target Set a traffice light target value to acheive, red if below, green if above
#' @examples
#' dkjustgage(50,0,100,title="speed")
#' @export
dkjustgage <- function(value=5,
  min=0,
  max=100,
  title="",
  label="",
  reverse=F,
  symbol="",
  target=NULL,
  # width = NULL,
  height = NULL) {

  # forward options using x
  x = list(
    value = value,
    min = min,
    max = max,
    label = label,
    title = title,
    reverse = reverse,
    symbol = symbol,
    target = target
  )

  # create widget
  htmlwidgets::createWidget(
    name = 'dkjustgage',
    x,
    width = width,
    height = height,
    package = 'dkjustgage'
  )
}

#' Shiny bindings for dkjustgage
#'
#' Output and render functions for using dkjustgage within Shiny
#' applications and interactive Rmd documents.
#'
#' @param outputId output variable to read from
#' @param width,height Must be a valid CSS unit (like \code{'100\%'},
#'   \code{'400px'}, \code{'auto'}) or a number, which will be coerced to a
#'   string and have \code{'px'} appended.
#' @param expr An expression that generates a dkjustgage
#' @param env The environment in which to evaluate \code{expr}.
#' @param quoted Is \code{expr} a quoted expression (with \code{quote()})? This
#'   is useful if you want to save an expression in a variable.
#'
#' @name dkjustgage-shiny
#'
#' @export
dkjustgageOutput <- function(outputId, width = '100%', height = '400px'){
  htmlwidgets::shinyWidgetOutput(outputId, 'dkjustgage', width, height, package = 'dkjustgage')
}

#' @rdname dkjustgage-shiny
#' @export
renderDkjustgage <- function(expr, env = parent.frame(), quoted = FALSE) {
  if (!quoted) { expr <- substitute(expr) } # force quoted
  htmlwidgets::shinyRenderWidget(expr, dkjustgageOutput, env, quoted = TRUE)
}

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
#' @param cutoffs An array of two numbers indicating the boundary between low-medium and medium-high
#' @param cutoffColos An array of three colors for low, medium and high
#' @param highIsGood If true colors range from red to green instead of green to red
#' @examples
#' dkjustgage(50,0,100,title="speed")
#' @export
dkjustgage <- function(value,
  min = 0,
  max = 100,
  title = "",
  width = NULL,
  height = NULL,
  cutoffs = NULL,
  target = NULL,
  targetPointer = T,
  cutoffColors = NULL,
  highIsGood = F,
  options = list()) {

  if (highIsGood & is.null(cutoffColors))
    cutoffColors = c("#ff0000", "#f09030","#a9d70b")
  else
    cutoffColors = c("#a9d70b", "#f09030","#ff0000")

  options$value= value
  options$min = min
  options$max = max
  options$title = title
  options$relativeGaugeSize = TRUE

  # if cutoffs supplied then defined custom sectors
  if (!is.null(cutoffs)) {
    options$customSectors = list(
      list(color=cutoffColors[1], lo=min, hi=cutoffs[1]),
      list(color=cutoffColors[2], lo=cutoffs[1], hi=cutoffs[2]),
      list(color=cutoffColors[3], lo=cutoffs[2], hi=max))
  }

  # if target supplied and custom sectors not set yet then define custom sectors
  if (!is.null(target)) {
    options$target = target
    options$targetPointer = targetPointer
    if (is.null(options$customSectors)) {
      options$customSectors = list(
        list(color="#ff0000", lo=min, hi=target-0.001),
        list(color="#f9c802", lo=target, hi=target+(max-target)*0.1),
        list(color="#a9d70b", lo=target+(max-target)*0.1, hi=max)
      )
    }
  }

  # load some default target pointer options
  if (is.null(options$targetPointerOptions))
    options$targetPointerOptions = list(
      toplength = 0,
      bottomlength = -40,
      bottomwidth = 8,
      color = '#8e8e93'
    )

  # create widget
  htmlwidgets::createWidget(
    name = 'dkjustgage',
    options,
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

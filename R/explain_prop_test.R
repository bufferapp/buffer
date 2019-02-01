#' Explain proportion test
#'
#' \code{explain_prop_test(prop_test)} returns a string explaining the results of a two-sample proportion test.
#' @param prop_test The proportion test object.
#' @return A string containing the explanation of the results of the test.
#' @keywords proportion test
#' @export
#' @examples
#' explain_prop_test(prop_test)


# function to explain two sample proportion test
explain_prop_test <- function(prop_test) {

  if ((length(prop_test$estimate) == 2)) {

    # say what test this is
    stmt1 <- "This was a two-sample proportion test of the hypothesis that the true population proportions are equal. "

    # determine if null hypothesis is rejected
    stmt2 <-
      if (prop_test$p.value < 1 - attr(prop_test$conf.int, "conf")) {
        "conclude that two population proportions are not equal."
      } else {
        "cannot conclude that two population proportions are different from one another. "
      }

    # explain difference in proportions
    stmt3 <-
      paste0(
        "The observed difference in proportions is ",
        round(prop_test$estimate[2] - prop_test$estimate[1], 3),
        ". The observed proportion for the first group is ",
        round(prop_test$estimate[1], 3),
        ", and the observed proportion for the second group is ",
        round(prop_test$estimate[2], 3), ". "
      )

    # explain confidence interval
    stmt4 <-
      paste0(
        round(abs(prop_test$estimate[2] - prop_test$estimate[1]), 3),
        " or less than ",
        round(-abs(prop_test$estimate[2] - prop_test$estimate[1]), 3)
      )

    # put final statement together
    final_stmt <-
      paste0(
        stmt1,
        "Using a significance level of ",
        1 - attr(prop_test$conf.int, "conf"),
        ", we ",
        stmt2,
        stmt3,
        "The confidence interval for the difference in proportions is (",
        round(prop_test$conf.int[1], 3),
        ", ",
        round(prop_test$conf.int[2], 3),
        "). ",
        "This interval will contain the difference in population proportions 95 times out of 100. ",
        "The p-value for this test is ",
        round(prop_test$p.value, 3),
        ". This is defined as the probability -- if the proportions are truly not different -- of observing this difference in sample proportions that is more extreme that what is observed in this data set. ",
        "In this case, this is the probability of observing a difference in sample proportions that is greater than ",
        stmt4, "."
      )

    final_stmt
  } else {
    "This function only explains two-sample proportion test. Your test is a one-sample test. :)"
  }
}

context("metaphone")

##  Test the soundex algorithm
test_that("Test that metaphone works", {
    skip_on_cran()

    test <- read.csv("metaphone.csv", comment.char = "#", stringsAsFactors = FALSE, colClasses = rep("character", 2), encoding = "UTF-8")

    ## Test for cases where clean = TRUE
    for(i in 1:nrow(test)) {
        if(is.na(test$value[i])) {
            expect_warning(testValue <- metaphone(test$word[i]))
            expect_true(is.na(testValue))
        } else
            expect_true(metaphone(test$word[i]) == test$value[i])
    }

    ## Test for cases where clean = FALSE, which should not
    ## return NA, so we are going to assume that's an error
    for(i in 1:nrow(test)) {
        if(is.na(test$value[i]))
            expect_false(is.na(metaphone(test$word[i], clean = FALSE)))
        else
            expect_true(metaphone(test$word[i], clean = FALSE) == test$value[i])
    }

})

test_that("The metaphone algorithm implementation can handle NAs", {
    skip_on_cran()

    test_data <- metaphone(NA_character_)
    expect_true(is.na(test_data))
})

test_that("The metaphone algorithm implementation can handle NULLs", {
    skip_on_cran()

    test_data <- metaphone(NULL)
    expect_true(is.na(test_data))
})

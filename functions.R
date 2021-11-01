# data reading function
dataset <- function(path, delim = '\\s', pattern = '\\s'){
    
    data <- read_delim(path, delim = delim, col_names = F) %>% 
        suppressMessages()
    
    data <- data$X1 %>% 
        str_split(pattern = pattern) %>% 
        unlist()
    
    data <- data[grepl(pattern = "\\S", x = data)] %>% 
        as.numeric()
}

# mean calculation function and standard deviation
summ <- function(x, row_names = NULL){
    # average calculation
    avg <- sapply(X = x, FUN = mean)
    
    # calculation of standard deviation
    s_d <- sapply(X = x, FUN = sd)
    
    # descriptive activity names to name the activities in the data set
    if(!is.null(row_names)){
        stopifnot(all(is.character(row_names) & length(row_names) == length(x)))
    }else{
        row_names <- names(x)
    }
    
    # data set with descriptive variable names. 
    colum_names <- c('mean','sd')
    
    # mean and standard deviation results
    matrix(data = c(avg, s_d), 
           nrow = c(length(avg), 2), 
           dimnames = list(row_names, colum_names) 
    )
}
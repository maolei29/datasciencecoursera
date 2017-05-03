







# Coursera R programming course 
# Week3, programming assignment 2

# A function to creat a matrix object that can cache its inverse matrix
# The function makeCacheMatrix takes a matrix as argument, retrun its 
# inverse. It has a function to cache the inverse in the environment as
# of function, will get this from cache if asked.

makeCacheMatrix <- function(x = matrix()) {
    i <- NULL  # i is the inverse of matrix x. First delete its value.
    
    # set
    set <- function(y) {
        x <<- y
        i <<- NULL
    } #set
    
    # get is a function with no arg. it return x, the arg of parent function
    get <- function(){ 
        x
    } #get
    
    # setInverse
    setInverse <- function(inverse) {
        i <<- inverse
    } #setInverse
    
    # function getInverse simply returns i
    getInverse <- function() {
        i
    } #getInverse
    
    # now a list that is to be returned, containing matrixes 'set', 
    # 'get', setInverse and getInverse:
    list(set = set, get = get, setInverse = setInverse, getInverse = getInverse)
} # makeCacheMatrix

###############
# A function that calculate inverse (solve) and cache the value:
cacheSolve <- function(x, ...) {
    i <- x$getInverse ()
    
    if(!is.null(i)) {
        print("...from cache...")
        return (i)
    } #if
    
    newMatrix <- x$get()
    i <- solve(newMatrix, ...)
    x$setInverse(i)
    return(i)
} #cacheSolve




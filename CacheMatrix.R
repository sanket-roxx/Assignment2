## The cachematrix.R file contains two functions, makeCacheMatrix() and cacheSolve(). 
## The first function in the file, makeCacheMatrix() creates an R object that stores 
## a matrix and its inverse (please check here (https://www.mathsisfun.com/algebra/matrix-inverse.html) 
## to understand the inverse of matrix. 
## The second function, cacheSolve() requires an argument 
## that is returned by makeCacheMatrix() in order to retrieve the inverse matrix 
## from the cached value that is stored in the makeVector() object's environment.
## The use of those functions can be useful when the inverse of a matrix has to be
## used multiple times within a program exectuion and/or the "to-be-computed" 
## dataset is very large. These two functions make the repeated inverse-computation of 
## unchanged matrices quicker than calling the solve() function at every instance.


## The first function, makeCacheMatrix creates a special "Matrix", which is really a 
## list containing a function to set the value of the original matrix, 
## get the value of the original matrix, set the inverse matrix, 
## get the inverse matrix.


makeCacheMatrix <- function(org_matrix = matrix()) {
        inv_matrix <- NULL
        set <- function(y) {
                org_matrix <<- y
                inv_matrix <<- NULL
        }
        get <- function() org_matrix
        setinverse <- function(solve) inv_matrix <<- solve
        getinverse <- function() inv_matrix
        list(set = set, get = get,
             setinverse = setinverse,
             getinverse = getinverse)

}


## The following function calculates the inverse of the special "matrix" created 
## with the above function. However, it first checks to see if the inverse has 
## already been calculated. If so, it gets the inverse from the cache and skips 
## the computation. Otherwise, it calculates the inverse of the matrix and sets 
## the inverse matrix in the cache via the setinverse function.

cacheSolve <- function(x, ...) {
        inv_matrix <- x$getinverse()
        if(!is.null(inv_matrix)) {
                message("getting cached data")
                return(inv_matrix)
        }
        data <- x$get()
        inv_matrix <- solve(data, ...)
        x$setinverse(inv_matrix)
        inv_matrix
}

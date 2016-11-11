PROGRAM matmulti1
  IMPLICIT NONE

  ! set number of rows and columns
  INTEGER, PARAMETER :: SIZE = 1000

  ! set the number of times the multiplication will be repeated
  INTEGER, PARAMETER :: NTIMES = 10

  ! Helper variables
  INTEGER :: i, tstart, tstop, trate
  REAL(kind=8) :: best_runtime

  ! generate square matrices
  REAL(kind=8), DIMENSION(SIZE, SIZE) :: A, B, C

  ! fill with random numbers
  CALL RANDOM_NUMBER(A)
  CALL RANDOM_NUMBER(B)

  ! run matrix multiplication "NTIMES" times and get runtime minimum
  best_runtime = HUGE(best_runtime)
  DO i = 1, NTIMES
     CALL SYSTEM_CLOCK(tstart)
     CALL MATMULTIPLY(SIZE, A, B, C)
     CALL SYSTEM_CLOCK(tstop, trate)
     best_runtime = MIN(best_runtime, DBLE(tstop-tstart)/DBLE(trate))
  END DO

  ! output
  PRINT *, "Running nested do loops", NTIMES, "times..."
  PRINT *, "Best runtime [seconds]:", best_runtime
  PRINT *, "Performance [GFLOPS]:", 2.d-9*DBLE(SIZE)**3/best_runtime

CONTAINS

  SUBROUTINE MATMULTIPLY(N, X, Y, Z)
    IMPLICIT NONE
    INTEGER, INTENT(IN) :: N
    REAL(kind=8), DIMENSION(N, N), INTENT(IN) :: X, Y
    REAL(kind=8), DIMENSION(N, N), INTENT(OUT) :: Z
    INTEGER :: i, j, k
    ! iterate through rows of matrix X
    DO i = 1, N
       ! iterate through columns of matrix Y
       DO j = 1, N
          ! initialise result matrix Z
          Z(i,j) = 0.d0
          ! iterate through rows of Y
          DO k = 1, N
             Z(i,j) = Z(i,j) + X(i,k) * Y(k,j)
          END DO
       END DO
    END DO
  END SUBROUTINE MATMULTIPLY

END PROGRAM matmulti1

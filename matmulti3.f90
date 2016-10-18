PROGRAM matmulti3
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
  ! use the BLAS level 3 routine DGEMM (general matrix multiplication)
  best_runtime = HUGE(best_runtime)
  DO i = 1, NTIMES
     CALL SYSTEM_CLOCK(tstart)
     CALL DGEMM("N", "N", SIZE, SIZE, SIZE, 1.d0, A, SIZE, B, SIZE, 0.d0, C, SIZE)
     !!PRINT *, MAXVAL(ABS((C-MATMUL(A,B))/C))
     CALL SYSTEM_CLOCK(tstop, trate)
     best_runtime = MIN(best_runtime, DBLE(tstop-tstart)/DBLE(trate))
  END DO

  ! output
  PRINT *, "Running nested for loops", NTIMES, "times..."
  PRINT *, "Best runtime [seconds]:", best_runtime

END PROGRAM matmulti3

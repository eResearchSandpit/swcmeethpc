PROGRAM matmulti2
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
  ! use the Fortran intrinsic function MATMUL
  best_runtime = HUGE(best_runtime)
  DO i = 1, NTIMES
     CALL SYSTEM_CLOCK(tstart)
     C = MATMUL(A,B)
     CALL SYSTEM_CLOCK(tstop, trate)
     best_runtime = MIN(best_runtime, DBLE(tstop-tstart)/DBLE(trate))
  END DO

  ! output
  PRINT *, "Running MATMUL intrinsic function", NTIMES, "times..."
  PRINT *, "Best runtime [seconds]:", best_runtime
  PRINT *, "Performance [GFLOPS]:", 2.d-9*DBLE(SIZE)**3/best_runtime

END PROGRAM matmulti2

CFLAGS = -std=gnu11 -Wall -Werror -Wextra -fopenmp -O3

.PHONY: all
all: program1 program2

.PHONY: clean
clean:
	$(RM) seq par

program1: nqueens.c
		gcc nqueens.c $(CFLAGS) -o seq
program2: nqueens_parallel.c
		gcc nqueens_parallel.c $(CFLAGS) -o par
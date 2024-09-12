CFLAGS = -std=gnu11 -Wall -Werror -Wextra -fopenmp -03

.PHONY: all
all: program1 program2

.PHONY: clean
clean:
	$(RM) seq par

program1: task3_sequential.c
		gcc nqueens.c $(CFLAGS) -o seq
program2: task3_parallel.c
		gcc nqueens_parallel.c $(CFLAGS) -o par
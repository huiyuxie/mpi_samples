# Makefile for MPI program

# Compiler and flags
MPICC = mpicc
CFLAGS = -I/opt/homebrew/Cellar/open-mpi/5.0.3/include
LDFLAGS = -L/opt/homebrew/Cellar/open-mpi/5.0.3/lib -lmpi -Wl,-ld_classic

# Default target executable name (can be overridden)
TARGET = mpi_program

# Source and object files
SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)

# Build all targets
all: $(TARGET)

# Link object files to create executable
$(TARGET): $(OBJS)
	$(MPICC) $(CFLAGS) -o $@ $(OBJS) $(LDFLAGS)

# Compile source files to object files
%.o: %.c
	$(MPICC) $(CFLAGS) -c $< -o $@

# Clean up
clean:
	rm -f $(OBJS) $(TARGET)

# Run program with 4 processes
run: $(TARGET)
	mpirun -np 12 ./$(TARGET)

# Declare phony targets
.PHONY: all clean run


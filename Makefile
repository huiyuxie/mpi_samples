# Makefile for MPI program

# Compiler and flags
MPICC = mpicc
CFLAGS = -I/opt/homebrew/Cellar/open-mpi/5.0.3/include
LDFLAGS = -L/opt/homebrew/Cellar/open-mpi/5.0.3/lib -lmpi -Wl,-ld_classic

# Base name of the target
BASE_NAME = mpi_helloBsend

# Target executable name
TARGET = $(BASE_NAME)

# Source and object files
SRCS = $(BASE_NAME).c
OBJS = $(BASE_NAME).o

# Build all targets
all: $(TARGET)

# Link object files to create executable
$(TARGET): $(OBJS)
	$(MPICC) -o $@ $(OBJS) $(LDFLAGS)

# Compile source files to object files
%.o: %.c
	$(MPICC) $(CFLAGS) -c $< -o $@

# Clean up
clean:
	rm -f $(OBJS) $(TARGET)

# Run program with specified number of processes
run: $(TARGET)
	mpirun -np 12 ./$(TARGET)

# Declare phony targets
.PHONY: all clean run
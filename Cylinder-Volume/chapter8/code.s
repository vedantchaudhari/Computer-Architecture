# Vedant Chaudhari
# Computer Architecture: Assignment 8.1
#
# Program Description:
# Computing the volume of a cylinder (x87)
# Formula: V = pi * r^2 * b

# Declare external functions
.extern _getDouble
.extern _printString
.extern _printDouble

.data           # Section for variable definitions
.balign 16
PI: .double 3.14159     # PI constant
radius: .double 0.0     # Radius
height: .double 0.0     # Height
solution: .double 0.0   # Solution

radiusMsg: .string "Enter radius: "
heightMsg: .string "Enter height: "
answerMsg: .string "Volume: "

.bss            # Section for uninitialized variables
.lcomm r_value, 8   # Holds radius value
.lcomm b_value, 8   # Holds height value
.lcomm s_value, 8   # Holds solution value

.text           # Section for instructions
.globl _asmMain    # Make the label "_main" available to the linker as an entry point for the program
_asmMain:          # Label for program entry

pushq %rbp
movq %rsp, %rbp     # Align stack pointer

leaq radiusMsg(%rip), %rdi      # Pass char* to _printString
callq _printString  # Call _printString
callq _getDouble    # Call _getDouble
movsd %xmm0, radius(%rip)   # Store return value (xmm0) into radius

leaq heightMsg(%rip), %rdi      # Pass char* to _printString
callq _printString  # Call _printString
callq _getDouble    # Call _getDouble
movsd %xmm0, height(%rip)   # Store return value (xmm0) into height

# Step 1: Find sqaure of radius
movsd radius(%rip), %xmm0   # Move radius into xmm0
mulsd %xmm0, %xmm0          # Multiple xmm0 by itself

# Step 2: Multiple radius by height
movsd height(%rip), %xmm1   # Move height into xmm1
mulsd %xmm0, %xmm1          # Multiply xmm0 by xmm1

# Step 3: Multiply by pi
movsd PI(%rip), %xmm0       # Move pi into xmm0
mulsd %xmm0, %xmm1          # Multiple xmm0 by xmm1
movsd %xmm1, solution(%rip) # Move xmm1 into solution

leaq answerMsg(%rip), %rdi  # Pass char* to _printString
callq _printString  # Call _printString
movsd solution(%rip), %xmm0 # Pass height to _printDouble
callq _printDouble  # Call _printDouble

popq %rbp       # End _asmMain
retq
.end            # End assembling

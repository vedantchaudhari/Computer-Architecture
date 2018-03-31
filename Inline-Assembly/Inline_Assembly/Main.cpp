//
//  Main.cpp
//  Macros
//
//  Created by Vedant Chaudhari on 3/29/18.
//  Copyright © 2018 Vedant Chaudhari. All rights reserved.
//

#include <iostream>

float getFloat()
{
    float num;
    std::cin >> num;
    return num;
}

int main()
{
    float num1, num2, solution;
    
    std::cout << "Inline Assembly and floating-point arithmetic Program" << std::endl;
    std::cout << "Float 1: ";
    num1 = getFloat();
    std::cout << "Float 2: ";
    num2 = getFloat();
    
    // Inline Assembly
    // Addition FPU operation
    solution = num1; // store the solution the problem in this variable, have to reset everytime lmao
    asm(".att_syntax \n\t"
        "movss %[num1], %%xmm0 \n\t"
        "movss %[num2], %%xmm1 \n\t"
        "addss %%xmm0, %%xmm1 \n\t"
        "movss %%xmm1, %[num1] \n\t"
        : [num1] "+x" (solution)
        : [num2] "x" (num2)
        : "%xmm0", "xmm1"
    );
    std::cout << "Addition Operation: " << solution << std::endl;
    
    // Inline Assembly, multiplication FPU operation
    solution = num1; // reset
    asm(".att_syntax \n\t"
        "movss %[num1], %%xmm0 \n\t"
        "movss %[num2], %%xmm1 \n\t"
        "mulss %%xmm0, %%xmm1 \n\t"
        "movss %%xmm1, %[num1] \n\t"
        : [num1] "+x" (solution)
        : [num2] "x" (num2)
        : "%xmm0", "xmm1"
    );
    std::cout << "Multiplication Operation: " << solution << std::endl;
    
    // Inline Assembly, division FPU operation
    solution = num1; // reset
    asm(".att_syntax \n\t"
        "movss %[num1], %%xmm0 \n\t"
        "movss %[num2], %%xmm1 \n\t"
        "divss %%xmm0, %%xmm1 \n\t"
        "movss %%xmm1, %[num1] \n\t"
        : [num1] "+x" (solution)
        : [num2] "x" (num2)
        : "%xmm0", "xmm1"
    );
    std::cout << "Division Operation: " << solution << std::endl;
    
    return 0;
}

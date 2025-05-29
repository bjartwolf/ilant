.assembly extern  mscorlib { auto }
.assembly Ant {}
.module Ant.dll

.namespace Foo {
    .class public auto ansi beforefieldinit Ant extends [mscorlib]System.Object
    {
        .method public static void HelloFromIl() cil managed
        {
            .entrypoint
            .maxstack 1

            ldstr "Hello, from the stack!"
            call void [System.Console]System.Console::WriteLine(string)
            //ldc.i4 1
            //call void [System.Console]System.Console::WriteLine(int32)
            ret
        }
        
        .method public static int32 Ant() cil managed
        {
            .maxstack 20
            .locals init (
                [0] native int*, // pointer to array of positions, was int32 but I tried native
                [1] int32, //x
                [2] int32,// y
                [3] int32 // direction
             )
             // https://en.wikipedia.org/wiki/List_of_CIL_instructions

//            https://learn.microsoft.com/en-us/dotnet/api/system.reflection.emit.opcodes.localloc?view=net-9.0
            ldc.i4 400
            localloc
            stloc.0
            
// use localalloc to allocate memory  
            // set x to 5
            ldc.i4.s 5 // x = 5
            stloc.1
            
            // set y = 5
            ldc.i4.s 5 
            stloc.2
            
            // set position to 1 in 2d array 
            ldloc.1 // load x 
            ldc.i4.8
            ldc.i4.2
            add // 10
            mul // x*10
            ldloc.2 // load y 
            add // 10*x + y
            ldc.i4.4 // int32 is 4 
            mul // (10x+7) * size of int32
            ldloc.0 // load pointer to array onto the stack 
            add // add to pointer 
            
            ldc.i4.s 1 
            // https://learn.microsoft.com/en-us/dotnet/api/system.reflection.emit.opcodes.stind_i4?view=net-9.0
            stind.i4 // store value at stack into memory addresss
            
            // function to print out the array to the console?
            // loop over the x and y and print it? Likely useful 
            // look from 0 to 400, skipping 4 and 4 bytes and print the contents (can do down, C64 style too)
    InitLoopAndPrint: 
            ldc.i4 0 // "i"
    LoopAndPrint:
            dup // duplicate the i so we can use it after add
            ldloc.0 // load pointer to array onto the stack 
            add // should be the address to the element...
            ldind.i4 // I think this loads the value it points too
            call void [System.Console]System.Console::Write(int32) // do not have to use line, but char
            
            
            ldc.i4 4 // skip four bytes since its int32
            add // i = i + 4
            // skip new line if we have not a mod 10
            dup
            ldc.i4 40 
            rem 
            brtrue AfterNewline
            
            call void [System.Console]System.Console::WriteLine() // do not have to use line, but char
            // only branch if i <= 400
    AfterNewline: 
            dup
            ldc.i4 400 
            clt
            brtrue LoopAndPrint 
            pop // we can not leave the counter on the stack, this gives invalid program
            
           // call void [System.Console]System.Console::WriteLine(int32)
            /*
            ldc.i4.1    
            conv.u1    
            stind.i1 

            */
            ldstr "running ant calculation!"
            call void [System.Console]System.Console::WriteLine(string)
            ldc.i4 17 
            ret
        }    
    }
}

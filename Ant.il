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
            .maxstack 10
            .locals init (
                [0] int32*, // pointer to array of positions
                [1] int32, //x
                [2] int32 // y
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
            
            ldc.i4.s 5 // y = 5
            stloc.2
            
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
            
           // call void [System.Console]System.Console::WriteLine(int32)
            /*
            ldc.i4.1    
            conv.u1    
            stind.i1 

            ldstr "running ant calculation!"
            call void [System.Console]System.Console::WriteLine(string)
            */
            ldc.i4 17 
            ret
        }    
    }
}

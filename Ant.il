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

            ldc.i4 400
            localloc
            stloc.0
            
//            https://learn.microsoft.com/en-us/dotnet/api/system.reflection.emit.opcodes.localloc?view=net-9.0
// use localalloc to allocate memory  
           
            ldloc.0 // load local variable onto stack      
            ldc.i4.s 55 // push onto the stack as int32
            ldc.i4.4 // int32 is 4 
            mul
            add
            
            ldc.i4.s 1 
            stind.i4
            
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

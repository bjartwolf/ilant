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
                // TODO store more compact 0 and 1 than int32
                // 2D array, color 0 = white, 1 = black
                [0] native int*, // pointer to array of positions, was int32 but I tried native
                [1] int32, //x
                [2] int32,// y
                [3] uint8 // direction, r = 0, u = 64, l = 128, d = 192, overflowing
             )
             // https://en.wikipedia.org/wiki/List_of_CIL_instructions
//            https://learn.microsoft.com/en-us/dotnet/api/system.reflection.emit.opcodes.localloc?view=net-9.0
            ldc.i4 3600  // 30x30x4
            localloc // use localalloc to allocate memory  on the stack for our 2d array
            stloc.0
            
            // set x to 5
            ldc.i4.s 15 // x = 5
            stloc.1
            
            // set y = 5
            ldc.i4.s 15 
            stloc.2
            
            // set dir to right 
            ldc.i4.s 0 
            stloc.3
             
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
            ldc.i4 120 // 30*x 
            rem 
            brtrue AfterNewline
            call void [System.Console]System.Console::WriteLine() // do not have to use line, but char
            // only branch if i <= 400
    AfterNewline: 
            dup
            ldc.i4 3600 
            clt
            brtrue LoopAndPrint 
            pop // we can not leave the counter we use to iterate on the stack, this gives invalid program
AntLoop:             
            // check the color, turn direction based on color
            // calculate current position in array, read that and flip with xor1 
            ldloc.1 // load x 
            ldc.i4 30
            mul // x 30*
            ldloc.2 // load y 
            add // 40*x + y
            ldc.i4.4 // int32 is 4 
            mul // (10x+7) * size of int32
            ldloc.0 // load pointer to array onto the stack 
            add // add to pointer 
            dup // keep pointer for later writing of color
            ldind.i1  // read value onto stack
            // 0 = white, 1 = black, which means true is black
            brfalse White
Black:            // black , do not need the label but good instead of comments to read flow? 
            // black is turn 90 counter-clockwise, positive direction 
            ldstr "Black"
            call void [System.Console]System.Console::WriteLine(string)
            ldloc.3
            ldc.i4 64 
            add
            conv.u1
            stloc.3
            ldc.i4.0 // load white on stack
            br WriteColor 
White:      
            ldstr "White"
            call void [System.Console]System.Console::WriteLine(string)
            ldloc.3
            ldc.i4 64 
            sub 
            conv.u1
            stloc.3
            ldc.i4.1  // load black on stack
 WriteColor: 
            stind.i1 // write uint8 back to array 
            ldstr "***"
            call void [System.Console]System.Console::WriteLine(string)
            ldstr "Dir: "
            call void [System.Console]System.Console::Write(string)
            ldloc.3
            call void [System.Console]System.Console::Write(int32)
            ldstr ""
            call void [System.Console]System.Console::WriteLine(string)
            
       
            // ends here
 Move:      // currently we do not change direction or look at direction
            ldloc.3 // load dir
            ldc.i4 0
            beq Right 
            ldloc.3 // load dir
            ldc.i4 64 
            beq Up 
            ldloc.3 // load dir
            ldc.i4 128
            beq Left
            br Down 
 Right:
            ldloc.2 // load y
            ldc.i4.1
            add 
            stloc.2 // write new y
            br InitLoopAndPrint 
 Left:
            ldloc.2 // load y
            ldc.i4.1
            sub 
            stloc.2 // write new y
            br InitLoopAndPrint 
 Up: 
            ldloc.1 // load x
            ldc.i4.1
            sub 
            stloc.1 // write new x
            br InitLoopAndPrint 
 Down: 
            ldloc.1 // load x
            ldc.i4.1
            add
            stloc.1 // write new x
            br InitLoopAndPrint 
   // move forward
            ldstr "running ant calculation!"
            call void [System.Console]System.Console::WriteLine(string)
            ldc.i4 17 
            ret
        }    
    }
}

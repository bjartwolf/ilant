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
    }
}

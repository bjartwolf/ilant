.assembly HelloWorld {}
.module HelloWorld.exe

.method static void Main() cil managed
{
    .entrypoint
    .maxstack 1

    ldstr "Hello, World!"
    call void [System.Console]System.Console::WriteLine(string)
    ret
}
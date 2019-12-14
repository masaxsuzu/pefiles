$ErrorActionPreference = "Stop"

function Exit-If($v) {
    if ($v) {
        exit 1;
    }
    echo "Ok"
}

$bin = "bin"
$asm = "app"

dotnet build .\NetCore\Build.NetCore.csproj -o ${bin}\a /t:ReBuild /p:AssemblyName=$asm
dotnet build .\NetCore\Build.NetCore.csproj -o ${bin}\b /t:ReBuild /p:AssemblyName=$asm

dotnet build .\NetFramework\Build.NetFramework.csproj -o ${bin}\c /t:ReBuild /p:AssemblyName=$asm /p:Deterministic=false
dotnet build .\NetFramework\Build.NetFramework.csproj -o ${bin}\d /t:ReBuild /p:AssemblyName=$asm /p:Deterministic=false
dotnet build .\NetFramework\Build.NetFramework.csproj -o ${bin}\e /t:ReBuild /p:AssemblyName=$asm /p:Deterministic=true
dotnet build .\NetFramework\Build.NetFramework.csproj -o ${bin}\f /t:ReBuild /p:AssemblyName=$asm /p:Deterministic=true

COMP ${bin}\a\$asm.exe ${bin}\b\$asm.exe /M; Exit-If(-not $?)
COMP ${bin}\c\$asm.exe ${bin}\d\$asm.exe /M; Exit-If($?)
COMP ${bin}\e\$asm.exe ${bin}\f\$asm.exe /M; Exit-If(-not $?)
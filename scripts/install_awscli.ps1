# Baixar instalador AWS CLI v2
$awsCliInstaller = "$env:TEMP\AWSCLIV2.msi"
$awsCliUrl = "https://awscli.amazonaws.com/AWSCLIV2.msi"

Write-Host "Baixando AWS CLI..."
Invoke-WebRequest -Uri $awsCliUrl -OutFile $awsCliInstaller -UseBasicParsing

Write-Host "Instalando AWS CLI..."
Start-Process msiexec.exe -ArgumentList "/i `"$awsCliInstaller`" /qn /norestart" -Wait

# Verifica instalação
$installPath = "C:\Program Files\Amazon\AWSCLIV2\aws.exe"
if (Test-Path $installPath) {
    Write-Host "✅ AWS CLI instalado com sucesso."
    # Opcionalmente adiciona ao PATH (temporário)
    $env:PATH += ";C:\Program Files\Amazon\AWSCLIV2"
    aws --version
} else {
    Write-Host "❌ Falha na instalação do AWS CLI. Verifique se rodou o script como Administrador."
}

# Define a versão desejada do Terraform
$terraformVersion = "1.12.2" ### aqui coloque a versão desejada

# Define a URL de download
$terraformUrl = "https://releases.hashicorp.com/terraform/$terraformVersion/terraform_${terraformVersion}_windows_amd64.zip"

# Caminhos
$downloadPath = "$env:TEMP\terraform.zip"
$installPath = "$env:USERPROFILE\bin\terraform"

# Cria o diretório de instalação, se não existir
if (-not (Test-Path $installPath)) {
    New-Item -ItemType Directory -Path $installPath | Out-Null
}

Write-Host "Baixando Terraform $terraformVersion..."
Invoke-WebRequest -Uri $terraformUrl -OutFile $downloadPath

Write-Host "Extraindo arquivos..."
Expand-Archive -Path $downloadPath -DestinationPath $installPath -Force

# Adiciona o diretório ao PATH do usuário se ainda não estiver
if (-not ($env:Path -split ";" | Where-Object { $_ -eq $installPath })) {
    Write-Host "Adicionando Terraform ao PATH..."
    $currentPath = [Environment]::GetEnvironmentVariable("Path", "User")
    $newPath = "$currentPath;$installPath"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "Feche e reabra o terminal para o PATH ser recarregado."
}

# Verifica a versão instalada
$terraformExe = Join-Path $installPath "terraform.exe"
if (Test-Path $terraformExe) {
    & $terraformExe version
} else {
    Write-Host "Terraform nao foi instalado corretamente."
}

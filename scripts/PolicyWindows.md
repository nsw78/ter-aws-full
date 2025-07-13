

### ⚠️ **Importante:** se estiver em uma máquina corporativa ou sem privilégios de administrador, talvez você precise de permissão ou usar o PowerShell com elevação (Executar como Administrador).

---

### ✅ **Solução rápida (apenas para esta sessão do PowerShell):**

No terminal, digite:

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

Depois, execute novamente seu script:

```powershell
.\install_ter.ps1
```

---

### 🔒 **Se quiser permitir permanentemente (mais permissivo):**

Execute o PowerShell **como Administrador** e digite:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
```

Isso permite que você execute scripts `.ps1` criados localmente.

---

### 🧾 Referência oficial:

[about\_Execution\_Policies – Microsoft Docs](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_execution_policies)

---

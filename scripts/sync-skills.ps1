#Requires -Version 5.1
<#
.SYNOPSIS
  Sync skills: .cursor/skills (canonical) -> .claude/skills (mirror).
.DESCRIPTION
  Both Cursor and Claude Code auto-discover in-repo project skills.
  .cursor/skills is the canonical edit location; this script mirrors it to
  .claude/skills.
  To keep a skill Cursor-only (e.g. an infra skill that needs your MCP
  tokens), set $Exclude below to its directory name — it is never mirrored.
  Run after 'git pull' and after editing any skill.
.PARAMETER Check
  Report drift without copying. Exit 0 = in sync, 1 = out of sync, 2 = error.
.EXAMPLE
  powershell -ExecutionPolicy Bypass -File scripts\sync-skills.ps1
  powershell -ExecutionPolicy Bypass -File scripts\sync-skills.ps1 -Check
#>
param([switch]$Check)

$ErrorActionPreference = 'Stop'
$root    = Split-Path -Parent $PSScriptRoot
$src     = Join-Path $root '.cursor\skills'
$dst     = Join-Path $root '.claude\skills'
# Set to a skill directory name to keep it Cursor-only (never mirrored):
$exclude = ''

if (-not (Test-Path $src)) { Write-Error "Canonical skills dir not found: $src"; exit 2 }

$xdArgs = @()
if ($exclude -ne '') { $xdArgs = @('/XD', $exclude) }

if ($Check) {
    robocopy $src $dst /MIR /L @xdArgs /NJH /NJS /NP /NC /NS /NDL | Out-Null
    if ($LASTEXITCODE -ge 8) { Write-Error "robocopy failed ($LASTEXITCODE)"; exit 2 }
    if ($LASTEXITCODE -gt 0) { Write-Host 'OUT OF SYNC - run: powershell -ExecutionPolicy Bypass -File scripts\sync-skills.ps1'; exit 1 }
    Write-Host 'Skills in sync.'
    exit 0
}

New-Item -ItemType Directory -Force $dst | Out-Null
robocopy $src $dst /MIR @xdArgs /NJH /NJS /NP
if ($LASTEXITCODE -ge 8) { Write-Error "robocopy failed ($LASTEXITCODE)"; exit 2 }
if ($exclude -ne '') { Write-Host "Synced .cursor/skills -> .claude/skills (excluded: $exclude)." }
else { Write-Host "Synced .cursor/skills -> .claude/skills." }
exit 0

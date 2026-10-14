[CmdletBinding()]
param([string]$ReportPath)

$ErrorActionPreference = 'Stop'
$repo = Split-Path $PSScriptRoot -Parent
Push-Location $repo
try {
    & git rev-parse --is-inside-work-tree | Out-Null
    if ($LASTEXITCODE) { throw 'Repository safety scan requires Git.' }
    $files = @(& git ls-files)
    $findings = [Collections.Generic.List[object]]::new()
    $scannerPath = 'scripts/Test-RepositorySafety.ps1'
    $forbiddenNames = '(?i)(^|/)(artifacts|bin|obj|\.vs|TestResults|quarantine)(/|$)|\.(dmp|dump|etl|evtx|pfx|p12|pem|key|jks|keystore|db|sqlite|sqlite3|jsonl)$|(^|/)PRE-CLEAN\.md$'
    foreach ($path in $files) {
        if ($path -match $forbiddenNames) { $findings.Add([pscustomobject]@{Rule='ForbiddenTrackedPath';Path=$path;Line=0}) }
    }

    $rules = [ordered]@{
        PrivateKey = '-----BEGIN ' + '(RSA |EC |OPENSSH |DSA )?PRIVATE KEY-----'
        AwsAccessKey = 'A' + 'KIA[0-9A-Z]{16}'
        GitHubToken = '(g' + 'h[pousr]_[A-Za-z0-9]{30,}|github_pat_[A-Za-z0-9_]{20,})'
        OpenAIKey = 's' + 'k-[A-Za-z0-9_-]{20,}'
        GoogleApiKey = 'A' + 'Iza[0-9A-Za-z_-]{30,}'
        SlackToken = 'x' + 'ox[baprs]-[0-9A-Za-z-]{10,}'
        AssignedSecret = '(?i)(api[_-]?key|client[_-]?secret|access[_-]?token|password)\s*[:=]\s*["''][^"'']{8,}["'']'
        ConnectionPassword = '(?i)(password|pwd)\s*=\s*[^;\s]{4,}'
        PersonalWindowsPath = '(?i)C:\\Users\\[^%<\\]+'
    }
    foreach ($path in $files) {
        if ($path -eq $scannerPath -or !(Test-Path -LiteralPath $path -PathType Leaf)) { continue }
        foreach ($rule in $rules.GetEnumerator()) {
            foreach ($match in @(Select-String -LiteralPath $path -Pattern $rule.Value -AllMatches -ErrorAction SilentlyContinue)) {
                $findings.Add([pscustomobject]@{Rule=$rule.Key;Path=$path;Line=$match.LineNumber})
            }
        }
    }
    $result = [ordered]@{
        schemaVersion=1; timestamp=[DateTimeOffset]::UtcNow.ToString('o'); trackedFiles=$files.Count
        passed=($findings.Count -eq 0); findings=@($findings)
    }
    if ($ReportPath) {
        $full = [IO.Path]::GetFullPath($ReportPath)
        New-Item -ItemType Directory -Path (Split-Path $full -Parent) -Force | Out-Null
        $result | ConvertTo-Json -Depth 5 | Set-Content -LiteralPath $full -Encoding utf8
    }
    if ($findings.Count) {
        $findings | Sort-Object Path,Line,Rule | Format-Table -AutoSize
        throw "Repository safety scan found $($findings.Count) item(s). Values were intentionally not printed."
    }
    Write-Output "Repository safety scan passed: $($files.Count) tracked files, 0 findings."
} finally { Pop-Location }

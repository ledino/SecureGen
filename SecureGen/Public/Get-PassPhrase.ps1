function Get-PassPhrase {
<#
.SYNOPSIS
Génère une passphrase robuste, lisible et conforme ANSSI/CNIL.

.DESCRIPTION
Get-PassPhrase est une façade publique qui délègue toute la logique interne
à Internal-GeneratePassPhrase.

La génération utilise automatiquement la meilleure source d’aléa selon la version
de PowerShell (PS7 : NIST SP 800‑90, PS5.1 : RNGCryptoServiceProvider).

Les recommandations ANSSI/CNIL (2021‑2024) sont appliquées :
- minimum 7 mots
- longueur totale ≥ 30 caractères
- priorité à la longueur

.EXAMPLE
Get-PassPhrase
Génère une passphrase de 7 mots de 6 lettres.

.EXAMPLE
Get-PassPhrase -Words 10 -Letters 5
Génère une passphrase longue et très entropique.

.PARAMETER LettersPerWord
Nombre de lettres par mot. Par défaut : 6.

.PARAMETER Words
Nombre de mots. Par défaut : 7.

.PARAMETER Separator
Séparateur entre les mots. Par défaut : "-".

.PARAMETER Charset
Ensemble des caractères utilisés pour générer les mots.

.PARAMETER NoClipboard
Désactive la copie automatique dans le presse‑papier.

.PARAMETER NoClear
Empêche l’effacement automatique du presse‑papier.

.PARAMETER Silent
Désactive tout affichage et tout bip.

.OUTPUTS
System.String
Retourne la passphrase générée.
#>
    
    [CmdletBinding()]
    param(
        # Paramètres de structure
        [int]$Words   = 7,
        [int]$Letters = 6,

        # Séparateur configurable
        [string]$Separator = '-',

        # Options d’enrichissement du charset
        [switch]$Uppercase,
        [switch]$Digits,

        # Options d’affichage / clipboard
        [switch]$NoClipboard,
        [switch]$NoClear,
        [switch]$Silent,

        # Nouveaux modes
        [switch]$Quiet,
        [switch]$Raw
    )

    # --- Mode RAW : retourne la phrase brute, aucun affichage ---
    if ($Raw) {
        return (Internal-GeneratePassPhrase `
            -Words $Words `
            -Letters $Letters `
            -Separator $Separator `
            -Uppercase:$Uppercase `
            -Digits:$Digits `
            -Silent `
            -NoClipboard `
            -NoClear)
    }

    # --- Mode QUIET : retourne uniquement la phrase, aucun décor ---
    if ($Quiet) {
        $phrase = Internal-GeneratePassPhrase `
            -Words $Words `
            -Letters $Letters `
            -Separator $Separator `
            -Uppercase:$Uppercase `
            -Digits:$Digits `
            -Silent `
            -NoClipboard `
            -NoClear

        return $phrase
    }

    # --- Mode SILENT : aucun affichage, retourne la phrase ---
    if ($Silent) {
        return (Internal-GeneratePassPhrase `
            -Words $Words `
            -Letters $Letters `
            -Separator $Separator `
            -Uppercase:$Uppercase `
            -Digits:$Digits `
            -Silent `
            -NoClipboard `
            -NoClear)
    }

    # --- Mode DEFAULT : UX complète ---
    return Internal-GeneratePassPhrase `
        -Words $Words `
        -Letters $Letters `
        -Separator $Separator `
        -Uppercase:$Uppercase `
        -Digits:$Digits `
        -NoClipboard:$NoClipboard `
        -NoClear:$NoClear `
        -Silent:$Silent
}
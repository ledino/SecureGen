function Invoke-Beep {
<#
.SYNOPSIS
Émet un bip sonore compatible Windows, Linux et macOS.

.DESCRIPTION
Invoke-Beep est une fonction utilitaire simple permettant d’émettre un bip sonore.

Elle est utilisée par d’autres cmdlets SecureGen (comme Get-PassWord et Get-PassPhrase)
pour signaler la fin d’une opération, sauf si l’utilisateur active l’option -Silent.

Le comportement dépend de la plateforme :
- Windows : utilise [Console]::Beep()
- Linux / macOS : utilise le caractère BEL (`\a`) ou une alternative compatible terminal

.EXAMPLE
Invoke-Beep
Émet un bip standard (800 Hz, 200 ms).

.EXAMPLE
Invoke-Beep -Frequency 1200
Émet un bip plus aigu (1200 Hz).

.EXAMPLE
Invoke-Beep -Duration 500
Émet un bip plus long (500 ms).

.EXAMPLE
Invoke-Beep -Frequency 1000 -Duration 300
Émet un bip personnalisé.

.PARAMETER Frequency
Fréquence du bip en Hertz (Hz).  
Plus la valeur est élevée, plus le son est aigu.  
Valeur par défaut : 800.

.PARAMETER Duration
Durée du bip en millisecondes (ms).  
Valeur par défaut : 200.

.OUTPUTS
None  
La fonction ne retourne aucune valeur.  
Elle produit uniquement un signal sonore.

.NOTES
Compatible Windows, Linux, macOS.  
Utilisé en interne par les autres cmdlets SecureGen.  
Peut être désactivé via l’option -Silent des autres cmdlets.
#>

    [CmdletBinding()]
    param(
        [int]$Frequency = 800,
        [int]$Duration  = 200
    )

    Internal-Beep -Frequency $Frequency -Duration $Duration
}

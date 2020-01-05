#!/bin/sh
# $1: Spruchname
# $2: Synonyme
# $3: Quelle
# $4: Stufen
# $5: Reichweite
# $6: Dauer
# $7: Kurzbeschreibung
# $8 ... : Beschreibung
cat `grep -l "§" *.txt` | gawk 'BEGIN {
RS="§\n"; FS="\n"
PROCINFO["sorted_in"]="@ind_str_asc"
print "# Sprüche alphabetisch"
No=0
}
{
No++
# Spruch in den Index aufnehmen
# spellindex[Spruchstufe][Spruch][Name/Reichweite ...]
sl=split($4, la, ", ")
for (i = 1 ; i <=sl; i++) {
   spellindex[la[i]][$1]["Name"]=$1
   spellindex[la[i]][$1]["ref"]="tag-" No
   spellindex[la[i]][$1]["src"]=$3
}

# aktuellen Spruch ausgeben
printf "## %s\n\n", $1 ; 
printf "\\index{%s}", $1 ;
printf "\\label{tag-%i}\n", No
ns=split ($2, a, ", ")
for ( i = 1; i <= ns; i++ ) {
   printf "\\index{%s}", a[i]
}
printf "\n\n"
printf "Spruchstufe\n:      %s\n\n", $4 ;
printf "Reichweite\n:      %s\n\n", $5 ;
printf "Dauer\n:      %s\n\n", $6 ;
for ( i=8 ; i < NF ; i++ )
{ 
  printf "%s\n", $i ;
}
printf "(%s - %s)\n\n", $2, $3
}
# Indextabelle ausgeben
END {
print "# Sprüche nach Stufe"
for ( i in spellindex ) {
   k=0
   printf "\n: %s\n\n", i     
   printf "|   | Spruch | Seite | \n"
   printf "|:--------|:--------|:-------|\n"
   for ( j in spellindex[i] ) {
       k++
       if ( spellindex[i][j]["src"] == "Men & Magic" ) {
          printf "| %i | %s | \\pageref{%s} |\n", k, spellindex[i][j]["Name"], spellindex[i][j]["ref"] 
       } else {
       printf "| %i | %s (%s) | \\pageref{%s} |\n", k, spellindex[i][j]["Name"], spellindex[i][j]["src"], spellindex[i][j]["ref"] }
   }
 }
}'  

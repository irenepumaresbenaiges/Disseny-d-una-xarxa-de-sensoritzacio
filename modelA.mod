# Conjunts
set INTERSECCIONS;	# identificadors de les interseccions de la xarxa
set CAMINS; # identificadors dels camins de la xarxa
set INTERSECCIONS_PROHIBIDES within INTERSECCIONS; # identificadors de les interseccions prohibides de la xarxa
set INTERSECCIONS_FIXES within INTERSECCIONS; # identificadors de les intserseccions fixes de la xarxa
set INTERSECCIONS_CAMINS within {CAMINS, INTERSECCIONS}; # parella d'identificadors de cami i interseccio (interseccio pertany al cami)


# Parametres
param f_c{CAMINS}>=0; # Fluxe que te el cami


# Variables
var s_i{INTERSECCIONS} binary; # Sensor en interseccion
var s_c{CAMINS}binary; # El cami te com a minim 2 interseccions amb sensor


# Funcio objetiu
maximize fluxe_total: sum {c in CAMINS} f_c[c] * s_c[c]; # Maximitzar el fluxe total dels camins sensoritzats


# Restriccions
subject to sensors_maxims: sum{i in INTERSECCIONS} s_i[i] <= 15; # Maxim 15 sensors en tota la xarxa

subject to cami_sensoritzat{c in CAMINS}: sum{(c,i) in INTERSECCIONS_CAMINS} s_i[i] >= 2 * s_c[c]; # Minim 2 sensors per cami

subject to interseccions_prohibides{i in INTERSECCIONS_PROHIBIDES}: s_i[i] = 0; # Les interseccions prohibides no poden tenir sensor

subject to interseccions_fixes{i in INTERSECCIONS_FIXES}: s_i[i] = 1; # Les interseccions fixes han de tenir sensor
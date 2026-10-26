library(readr)
library(dplyr)

# En este script se realiza el proceso de limpieza de los datos que corresponden a los 
# registros de presencia de las aves en los distintos tipos de suelo. Como es el mismo proceso
# para los tres tipos de suelo y por ende es el mismo codigo, solo se documenta en suelo rural 
# el proceso de limpieza, luego el proceso de unificación de los data frames.

#--------------- SUELO RURAL ---------------------------------------

suelo_rural <- read_delim("data/raw_data/raw_datos_avistamiento/suelo_rural.csv",
delim = "\t", escape_double = FALSE,
col_types = cols(datasetKey = col_skip()),
trim_ws = TRUE) #Importa los datos en crudo

#Elimina los NA de la columna de conteo individual
# usando indexación logica de vecotres, remplazando
# los NA por 1.

suelo_rural$individualCount[is.na(suelo_rural$individualCount)] <- 1 

#Seleciona solo las columnas de interés para el estudio,
#con la funcion select() y agrega la columna floorType a 
#todas las filas del data frame con mutate()

suelo_rural_limpio <- suelo_rural |> select(species, individualCount,  
                    decimalLatitude, decimalLongitude, month, year)|>  
                    mutate(floorType = "rural")                        

##guarda el data frame resultante en un csv con el nombre 
#"suelo_rural_limpio.csv"

write.csv(suelo_rural_limpio, file = "suelo_rural_limpio.csv", row.names = F) 
                                                                              
#------------------ SUELO EN EXPANSIÓN ................................

suelo_en_expansion <- read_delim("data/raw_data/raw_datos_avistamiento/suelo_en_expansion.csv",
delim = "\t", escape_double = FALSE,
trim_ws = TRUE)

suelo_en_expansion$individualCount[is.na(suelo_en_expansion$individualCount)] <- 1

suelo_en_expansion_limpio <- suelo_en_expansion |> select(species, individualCount,
                             decimalLatitude, decimalLongitude, month, year)|> 
                             mutate(floorType = "en expansión")

write.csv(suelo_en_expansion_limpio, file = "suelo_en_expansion_limpio.csv", row.names = F)

#------------------ SUELO URBANO -----------------------------------------

suelo_urbano <- read_delim("data/raw_data/raw_datos_avistamiento/suelo_urbano.csv",
delim = "\t", escape_double = FALSE,
trim_ws = TRUE)

suelo_urbano$individualCount[is.na(suelo_urbano$individualCount)] <- 1

suelo_urbano_limpio <-  suelo_urbano |> select(species, individualCount,
                        decimalLatitude, decimalLongitude, month, year)|> 
                        mutate(floorType = "urbano")

write.csv(suelo_urbano, file = "suelo_urbano_limpio.csv", row.names = F)

#------------UNIÓN DE LOS CSV Y CREACION DEL NUEVO---------------------------------------

#Usa la funcion bind_rows() para unir los 
#data frames ya creados en un solo csv.

csv_unido <- bind_rows(suelo_urbano_limpio, suelo_en_expansion_limpio, suelo_rural_limpio) |> 
  write.csv(file = "registros_avistamiento_todos_los_suelos.csv") 


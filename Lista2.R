# ================================================
# Lista de Exercícios 2 - R
# ================================================

# =======================
# Definindo os vetores
# =======================

# Datas correspondentes aos registros
DATA <- c("2025-08-01", "2025-08-01", "2025-08-01", "2025-08-01", "2025-08-02",
          "2025-08-02", "2025-08-02", "2025-08-02", "2025-08-03", "2025-08-03",
          "2025-08-03", "2025-08-03", "2025-08-04", "2025-08-04", "2025-08-04",
          "2025-08-04", "2025-08-05", "2025-08-05", "2025-08-05", "2025-08-05",
          "2025-08-06", "2025-08-06", "2025-08-06", "2025-08-06", "2025-08-07",
          "2025-08-07", "2025-08-07", "2025-08-07", "2025-08-08", "2025-08-08",
          "2025-08-08", "2025-08-08", "2025-08-09", "2025-08-09", "2025-08-09",
          "2025-08-09", "2025-08-10", "2025-08-10", "2025-08-10", "2025-08-10",
          "2025-08-11", "2025-08-11", "2025-08-11", "2025-08-11", "2025-08-12",
          "2025-08-12", "2025-08-12", "2025-08-12", "2025-08-13", "2025-08-13",
          "2025-08-13", "2025-08-13", "2025-08-14", "2025-08-14", "2025-08-14",
          "2025-08-14", "2025-08-15", "2025-08-15", "2025-08-15", "2025-08-15",
          "2025-08-16", "2025-08-16", "2025-08-16", "2025-08-16", "2025-08-17",
          "2025-08-17", "2025-08-17", "2025-08-17", "2025-08-18", "2025-08-18",
          "2025-08-18", "2025-08-18", "2025-08-19", "2025-08-19", "2025-08-19",
          "2025-08-19", "2025-08-20", "2025-08-20", "2025-08-20", "2025-08-20",
          "2025-08-21", "2025-08-21", "2025-08-21", "2025-08-21", "2025-08-22",
          "2025-08-22", "2025-08-22", "2025-08-22", "2025-08-23", "2025-08-23",
          "2025-08-23", "2025-08-23", "2025-08-24", "2025-08-24", "2025-08-24",
          "2025-08-24", "2025-08-25", "2025-08-25", "2025-08-25", "2025-08-25",
          "2025-08-26", "2025-08-26", "2025-08-26", "2025-08-26", "2025-08-27",
          "2025-08-27", "2025-08-27", "2025-08-27", "2025-08-28", "2025-08-28",
          "2025-08-28", "2025-08-28", "2025-08-29", "2025-08-29", "2025-08-29",
          "2025-08-29", "2025-08-30", "2025-08-30", "2025-08-30", "2025-08-30",
          "2025-08-31", "2025-08-31", "2025-08-31", "2025-08-31")

# Período do dia em que os dados foram coletados
PERIODO <- c("Madrugada", "Manhã", "Noite", "Tarde", "Madrugada", "Manhã", "Noite",
             "Tarde", "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada", "Manhã",
             "Noite", "Tarde", "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada",
             "Manhã", "Noite", "Tarde", "Madrugada", "Manhã", "Noite", "Tarde",
             "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada", "Manhã", "Noite",
             "Tarde", "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada", "Manhã",
             "Noite", "Tarde", "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada",
             "Manhã", "Noite", "Tarde", "Madrugada", "Manhã", "Noite", "Tarde",
             "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada", "Manhã", "Noite",
             "Tarde", "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada", "Manhã",
             "Noite", "Tarde", "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada",
             "Manhã", "Noite", "Tarde", "Madrugada", "Manhã", "Noite", "Tarde",
             "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada", "Manhã", "Noite",
             "Tarde", "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada", "Manhã",
             "Noite", "Tarde", "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada",
             "Manhã", "Noite", "Tarde", "Madrugada", "Manhã", "Noite", "Tarde",
             "Madrugada", "Manhã", "Noite", "Tarde", "Madrugada", "Manhã", "Noite",
             "Tarde", "Madrugada", "Manhã", "Noite", "Tarde")

# Radiação global em Kj/m2 (valores como caracteres para depois transformar em numérico)
`RADIACAO GLOBAL (Kj/m2)` <- c("NaN", "1328.74", "281.2", "2164.3", "NaN", "1387.06",
                               "243.2", "2388.13333333333", "NaN", "1414.92", "274.2", "2409.11666666667", "NaN",
                               "1223.98", "162.9", "2144.95", "NaN", "1057.18", "59.3", "1258.1", "NaN", "1361.34",
                               "148.1", "2062.03333333333", "NaN", "1373.48", "197.4", "1782.61666666667", "NaN",
                               "1278.08", "198.8", "1457.98333333333", "NaN", "1298.62", "243.7", "2177.1", "NaN",
                               "1425.54", "257.2", "2348.25", "NaN", "1405.58", "247.4", "2398.66666666667", "NaN",
                               "1487.14", "285.6", "2450.06666666667", "NaN", "1374.52", "346.3", "1980.7", "NaN",
                               "1350.08", "187.1", "2298.85", "NaN", "1412.74", "332", "2340.3", "NaN", "1472.02",
                               "303.2", "2424.58333333333", "NaN", "1464.72", "297.4", "2429.7", "NaN", "1493.22",
                               "310.4", "2441.15", "NaN", "1505.86", "323.8", "2481.9", "NaN", "1483.3", "289",
                               "2408.98333333333", "NaN", "1454.54", "314.4", "2490.4", "NaN", "1561.16", "325.9",
                               "2571.58333333333", "NaN", "1380.38", "143.75", "2365.46666666667", "NaN", "1525.8",
                               "324.5", "2506.63333333333", "NaN", "1559.68", "319.9", "2556.78333333333", "NaN",
                               "1560.52", "333.5", "2590.25", "NaN", "1555.8", "177.3", "2467.95", "NaN",
                               "1511.04", "317.1", "2332.73333333333", "NaN", "1510.94", "160.2", "2464.34",
                               "NaN", "1552.78", "232", "2415.73333333333", "NaN", "1609.44", "319.3",
                               "2439.38333333333")

# Umidade relativa do ar em %
`UMIDADE RELATIVA DO AR (%)` <- c(72, 72.67, 55.17, 42.33, 63.83, 62, 46.83, 26.83,
                                  56, 56.17, 38.5, 31.33, 53.17, 51.67, 41.5, 26, 68.33, 55.17, 50.5, 33.17, 74.33,
                                  64.17, 52, 34, 73, 59.83, 46.5, 32.17, 61.17, 46.67, 47.83, 28.33, 55.33, 58.83,
                                  52.17, 30, 60.5, 46.67, 42.83, 20.83, 44.83, 41.17, 35.17, 21, 37.33, 32.67, 35,
                                  19.67, 52.83, 51.17, 39.17, 27.83, 61.67, 61.5, 44.33, 26.67, 53.83, 45, 40.67,
                                  27.5, 50.5, 51.67, 38.33, 28.67, 49, 49.67, 37.67, 26.67, 61.5, 44.83, 34, 21.33,
                                  51.67, 36.67, 30.83, 22, 50.83, 49.5, 31.33, 22.33, 44.83, 35.67, 25.17, 15.67,
                                  30.83, 28.17, 23, 16, 45.17, 47.5, 30.67, 21, 55.67, 45.67, 31.67, 21.83, 41.33,
                                  38, 29.5, 21.33, 40.67, 44.67, 29.67, 23.5, 47, 45, 32.5, 25, 39.33, 37.83,
                                  31.67, 22.83, 38.67, 41.5, 35.17, 28.8, 67.5, 59.17, 47.83, 32.67, 55.2, 52.83,
                                  36.67, 25.5)

# Velocidade do vento em m/s (valores como caracteres)
`VENTO VELOCIDADE (m/s)` <- c("2.63", "3.13", "2.8", "3.12", "2.97", "3.62", "2.67",
                              "3.48", "2.07", "3.45", "2.55", "3", "1.9", "2.07",
                              "1.92", "2.23", "1.32", "2.17", "1.48", "1.45", "1.58",
                              "2.6", "1.53", "2.27", "1.07", "2.02", "1.45", "1.95",
                              "0.88", "1.57", "1.18", "2.23", "1.2", "2.82", "2.27",
                              "2.97", "1.58", "1.8", "2.25", "3.77", "1.6", "1.73",
                              "2.03", "3.08", "1.47", "2.23", "1.73", "2.8", "1.4",
                              "2.73", "1.55", "2.35", "1.83", "2.1", "1.35", "1.78",
                              "1.92", "3.3", "2.5", "3.22", "3.8", "3.6", "2.55",
                              "3.28", "3.12", "3.12", "2.48", "3.25", "1.1", "2.38",
                              "1.97", "3.6", "1.37", "3.28", "1.83", "3.03", "2.07",
                              "2.53", "2.13", "2.38", "1.73", "2.43", "2.82", "4.12",
                              "2.45", "2.65", "2.13", "3.3", "1.63", "2.25", "1.78",
                              "2.12", "1.17", "2.52", "2.23", "2.67", "2.4", "3.37",
                              "2.57", "3.07", "2.12", "3.58", "2.3", "3.5", "2.15",
                              "3.42", "2.52", "2.75", "2.37", "2.93", "2.72", "2.93",
                              "2.78", "2.9", "3.12", "3.64", "2.9", "3.83", "2.7",
                              "3.02", "2.22", "4.37", "2.37", "2.23")

# ================================================
# Exercício 1
# ================================================

# a) Transformar radiação global em numérico e arredondar
`RADIACAO GLOBAL (Kj/m2)` <- as.numeric(`RADIACAO GLOBAL (Kj/m2)`) 
round(`RADIACAO GLOBAL (Kj/m2)`)

# b) Transformar período em fator com níveis ordenados
PERIODO <- factor(PERIODO, levels = c("Madrugada", "Manhã", "Tarde", "Noite"))
levels(PERIODO) 
PERIODO 

# c) Criar matriz com todos os dados do período e transpor
matriz <- matrix(PERIODO) # Cria uma matriz
t(matriz) # Transpõe a matriz
# Observação: transpor muda a orientação da visualização dos dados, mas o tipo dos dados continua sendo fator

# ================================================
# Exercício 2
# ================================================

# a) Criar DataFrame e formatar nomes das colunas
teste <- data.frame(PERIODO, `RADIACAO GLOBAL (Kj/m2)`) # Criando DF
names(teste) <- tolower(names(teste)) # Transformar nomes em minúsculas
names(teste) <- gsub(" ", "_", names(teste))
names(teste) 

# b) Calcular médias manualmente e com mean()
# Média da umidade
sum(`UMIDADE RELATIVA DO AR (%)`) / length(`UMIDADE RELATIVA DO AR (%)`)
mean(`UMIDADE RELATIVA DO AR (%)`) 

sum(`RADIACAO GLOBAL (Kj/m2)`) / length(`RADIACAO GLOBAL (Kj/m2)`)
mean(`RADIACAO GLOBAL (Kj/m2)`, na.rm = TRUE) 

# ================================================
# Exercício 3
# ================================================

# a) Transformar DATA em formato Date
DATA <- as.Date(DATA, "%Y-%m-%d") 
DATA

# b) Exemplo de média da umidade na primeira semana
primeira_semana <- DATA <= as.Date("2025-08-07")
mean(`UMIDADE RELATIVA DO AR (%)`[primeira_semana], na.rm = TRUE) 
mean(`UMIDADE RELATIVA DO AR (%)`[!primeira_semana], na.rm = TRUE) 

# c) Classificação da umidade
faixa_de_alerta <- rep(NA, length(`UMIDADE RELATIVA DO AR (%)`)) 
faixa_de_alerta[`UMIDADE RELATIVA DO AR (%)` > 60] <- "Normal"
faixa_de_alerta[`UMIDADE RELATIVA DO AR (%)` <= 60 & `UMIDADE RELATIVA DO AR (%)` > 30] <- "Atenção"
faixa_de_alerta[`UMIDADE RELATIVA DO AR (%)` <= 30 & `UMIDADE RELATIVA DO AR (%)` > 20] <- "Alerta"
faixa_de_alerta[`UMIDADE RELATIVA DO AR (%)` <= 20] <- "Emergência"

# Adicionar coluna ao DataFrame
teste$faixa_de_alerta <- faixa_de_alerta
head(teste)
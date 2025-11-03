# Aula 1 ---------------------------------------------------------------
# Introdução ao R para análise de dados de imigração
# Semana Universitária (SEMUNI) de 2025 da Universidade de Brasília (UnB)
# -----------------------------------------------------------------------

#DICAS: USE O ?HELP para descobrir
help(sum)
?sum

#O R é uma calculadora
((5 * 3 ) + (10/2))^ 2 # não guardou informação

#guardar objetos
a = 5
b = 3
c = 10
d = 2 
((a*b) + (c/2)) ^ d # mesma conta

# Trabalhar com microdados

#------------------------------------------
# PRIMEIRO: pre-leitura dos microdados (formato .csv)
#-----------------------------------------

getwd() #pasta onde o R trabalha

# se não souber a pasta:
# session > Set working directory > choose directory

setwd("~/Documentos/minucurso R") # coloca a pasta que contém os dados
dir() # ver qual diretório  eu estou trabalhando, o que tem nele

# Para a leitura tem que ter cuidado para ler 
# acentos, e algumas configurações podem bugar de máquina para máquina
# ";" - também pode ter os erros se o separador estiver no banco de 
# dados sem ser para separar tabelas

# confere primeiro: 

readLines("CGIL_CNIg_2024.csv",10) # estrutura dos dados

# se eu uso esse encoding errado da problema na leitura da base

dadosErrados = read.csv2("CGIL_CNIg_2024.csv", fileEncoding = "latin1")
dados = read.csv2("CGIL_CNIg_2024.csv", fileEncoding = "UTF-8")

#ver as primeiras linhas dos dados
head(dados,2)

# ver as dimensões dos dados

dim(dados)
#número de linhas x numero de colunas -> 56898  X  17

nrow(dados) # número de linhas
ncol(dados) #número de dados

#-------------------------------------------------
# SEGUNDO: selecionando linhas e colunas específicas
#--------------------------------------------------

names(dados)
dados$andamento
table(dados$andamento) #tabela de frequência


dados[,]  #dados[número da linha que eu quero, número coluna que eu quero]
dados[1,1] # só uma linha
dados[c(1,5,10),c(2,4)] #mais de uma linha

#Teste lógico
a == 5
a == 6

dadosDeferidos = dados[dados$andamento == "DEFINIDOS",]
dadosAnoAndamento = dados[,c("ano","andamento")]

# Como o R trabalha com a memória sempre que terminar de usar  um dado
# por boa prática vale a pena apagar o que não vai ser usado mais

rm(a,b,c,d,dadosAnoAndamento,dadosDeferidos,dadosErrados)

#--------------------------------------------
# OBJETIVO: Tabelas de frequências
#--------------------------------------------
# OBJETIVO SECUNDÁRIO: analisar e juntar a tabela dso dois anos!!!!!!

#Filtros que serao aplicados:
## andamento - DEFERIDO
## mes - 09
## modalidade - CGIL 

#  Variaveis de interesse: tipo de visto, pais de origem, faixa etaria,
## sexo, amparo, escolaridade, ocupacao, estado destino, valor do investimento
dadosFiltrados = dados[
      dados$andamento == "DEFERIDO" &
      dados$mes == 9 &
      dados$modalidade =="CGIL", 
      c("tipo_visto", "andamento", "amparo_legal", "modalidade",
                                   "mes", "ano", "valor_investimento_ajustado", "uf_estrangeiro",
                                   "data_nascimento", "genero", "escolaridade", "pais",
                                   "codigo_cbo")
]

#Para o relatorio tabular, desejamos agregar as informacoes de 2025
#será necessario utilizar uma agregacao entre os dados de 2024 e de 2025
dados25 = read.csv2("CGIL_CNIg_jan-set2025.csv", fileEncoding = "UTF-8")
dados25Filtrados =  dados25[
  dados25$andamento == "DEFERIDO" &
    dados25$mes %in% c(8,9) &
    dados25$modalidade == "CGIL" &
    dados25$ano == "2025",
  c("tipo_visto", "andamento", "amparo_legal", "modalidade",
    "mes", "ano", "valor_investimento_ajustado", "uf_estrangeiro",
    "data_nascimento", "genero", "escolaridade", "pais",
    "codigo_cbo")  
]

#verificando se as colunas estao iguais
names(dadosFiltrados)
names(dados25Filtrados)

names(dadosFiltardos)==names(dados25Filtrados)#teste logico de igualdade

## juntando dados de 2024 e 2025
dadosFinal <- rbind.data.frame(dadosFiltrados, dados25Filtrados)


###------------------------------------------
# Tabelas de frequências e Manupulacao das variaveis de interesse
###------------------------------------------
# criando variavel 'ano_mes' a partir das variaveis 'ano' e 'mes'

dadosFinal$ano_mes <- paste(dadosFinal$ano, dadosFinal$mes, sep="_")
table(dadosFinal$ano_mes)

#sexo
table(dadosFinal$genero)
dadosFinal$genero <- factor(dadosFinal$genero,
                             levels = c("M", "F"),
                             labels = c("Masculino", "Feminino"))
table(dadosFinal$genero)
table(dadosFinal$genero, dadosFinal$ano_mes)


#add o total das linhas
addmargins(table(dadosFinal$genero, dadosFinal$ano_mes),1) #total so de linha
addmargins(table(dadosFinal$genero, dadosFinal$ano_mes),2) #total so de coluna
addmargins(table(dadosFinal$genero, dadosFinal$ano_mes)) #total so de tudo

#atribuir a um objeto e exportar para o diretorio
tab=addmargins(table(dadosFinal$genero, dadosFinal$ano_mes),1) #salva em um objeto
write.csv2(tab, "tabela1.csv", row.names = TRUE) # envia para o documentos com esse nome

#tipo de visto
table(dadosFinal$tipo_visto)
(tab2=addmargins(table(dadosFinal$tipo_visto, dadosFinal$ano_mes,dadosFinal$genero),1))
write.csv2(tab2, "tabela2.csv", row.names = TRUE,fileEncoding = "latin1")
# A partir dessa tabela no excel editar ela 

#paises
table(dadosFinal$pais)
(tab3=addmargins(table(dadosFinal$pais, dadosFinal$ano_mes),1))
#write.csv2(tab3, "tabela3.csv", row.names = TRUE)

#escolaridade
table(dadosFinal$escolaridade)
levels(as.factor(dadosFinal$escolaridade))

# Foi botado um numero antes do nivel de escolaridade
# pois o R ordem alfabetica
# mas no padrão existe uma  ordem certa 

#transformar e padronizar os niveis da variavel escolaridade
dadosFinal$escolaridade[dadosFinal$escolaridade=="Doutorado"]
dadosFinal$escolaridade[dadosFinal$escolaridade=="Doutorado"]="8_Doutorado"
dadosFinal$escolaridade[dadosFinal$escolaridade=="Mestrado"]="7_Mestrado" 
dadosFinal$escolaridade[dadosFinal$escolaridade=="Especialização"]="6_Pós-Graduação"
dadosFinal$escolaridade[dadosFinal$escolaridade=="Fundamental Completo"]="3_Fundamental"
dadosFinal$escolaridade[dadosFinal$escolaridade=="Fundamental Incompleto"]="2_Fundamental Incompleto"
dadosFinal$escolaridade[dadosFinal$escolaridade=="Médio Completo"]="4_Médio"
dadosFinal$escolaridade[dadosFinal$escolaridade=="Médio Incompleto"]="3_Fundamental"
dadosFinal$escolaridade[dadosFinal$escolaridade=="Pós-doutorado"]="8_Doutorado"
dadosFinal$escolaridade[dadosFinal$escolaridade=="Superior Completo"]="5_Superior"
dadosFinal$escolaridade[dadosFinal$escolaridade=="Superior Incompleto"]="4_Médio"
table(dadosFinal$escolaridade)
(tab4=addmargins(table(dadosFinal$escolaridade, dadosFinal$ano_mes),1))
#write.csv2(tab4, "tabela4.csv", row.names = TRUE)

#Unidade da Federacao
table(dadosFinal$uf_estrangeiro)
(tab5=addmargins(table(dadosFinal$uf_estrangeiro, dadosFinal$ano_mes),1))
#write.csv2(tab5, "tabela5.csv", row.names = TRUE)

#faixa etaria
#primeiro, calcular a idade a partir da data de nascimento
dadosFinal$data_nascimento <- as.Date(dadosFinal$data_nascimento)
#utilizar uma data de referencia para o calculo da idade
#para fins de exemplificacao, utilizaremos a data do mesmo mes em que foi concedida a autorizacao
dadosFinal$ano
dadosFinal$mes
paste(dadosFinal$ano, dadosFinal$mes, "01", sep = "-")
data_ref <- as.Date(paste(dadosFinal$ano, dadosFinal$mes, "01", sep = "-"))

#dias entre o nascimento e a data de referencia
difftime(data_ref,dadosFinal$data_nascimento,unit="days")
#conversao para anos, levando em consideracao anos bisestos
difftime(data_ref,dadosFinal$data_nascimento,unit="days")/365.25
#escolher apenas a parte inteira do numero
floor(difftime(data_ref,dadosFinal$data_nascimento,unit="days")/365.25)
#atribuir a variavel idade
dadosFinal$idade <- floor(difftime(data_ref,dadosFinal$data_nascimento,unit="days")/365.25)

# fazer uma conferencia da variavel idade
dadosFinal$idade[1:10]#10 primeiras idades
dadosFinal$data_nascimento[1:10]#10 primeiras datas de nascimento
data_ref[1:10]#10 primeiras datas de referencia
table(dadosFinal$idade)
# em uma tabela de idade -1 e 0 não fazem sentido nessa base de dados
# < 17 também não fazem muito sentido

dadosFinal[dadosFinal$idade==-1,]

#criando faixas de idade
#dadosFinal$faixa_etaria <- NA
#para fins de exemplo didatico, vamos adotar que idades menores que 15 serao consideradas NA
dadosFinal$faixa_etaria[dadosFinal$idade < 15 ] <- "Não informado"
dadosFinal$faixa_etaria[dadosFinal$idade >= 15 & dadosFinal$idade < 20 ] <- "0_Menor que 20"
dadosFinal$faixa_etaria[dadosFinal$idade >= 20 & dadosFinal$idade <= 34 ] <- "20-34"
dadosFinal$faixa_etaria[dadosFinal$idade >= 35 & dadosFinal$idade <= 49 ] <- "35-49"
dadosFinal$faixa_etaria[dadosFinal$idade >= 50 & dadosFinal$idade <= 64 ] <- "50-64"
dadosFinal$faixa_etaria[dadosFinal$idade >= 65] <-"65 ou mais"

table(dadosFinal$faixa_etaria)
#Faixa temporal
# O R ordenou por ordem alfabetica não deve ser assim 
# deve colocar  o número anterior para aquele qeu quer que fique em cim "0_menor_que"
(tab6=addmargins(table(dadosFinal$faixa_etaria, dadosFinal$ano_mes),1))
#write.csv2(tab6, "tabela6.csv", row.names = TRUE)

#Resolucao Normativa
table(dadosFinal$amparo_legal)
#transformar dos dados em factor
levels(as.factor(dadosFinal$amparo_legal))
#ler a base de RNs
dir()
readLines("RNs_geral_17052025.csv",10)
rns <- read.csv2("RNs_geral_17052025.csv", fileEncoding = "UTF-8")

#verificar se todos os amparos estao na base de RNs
dadosFinal$amparo_legal%in%rns$amparo_legal
dadosFinal$amparo_legal[!dadosFinal$amparo_legal%in%rns$amparo_legal]

#juntar a base de dados com as informacoes de RNs por meio de um 'merge'
dadosFinal2 <- merge.data.frame(dadosFinal, rns,
                                 by.x = "amparo_legal",
                                 by.y = "amparo_legal",
                                 all.x = TRUE)
table(dadosFinal2$RN)
(tab7=addmargins(table(dadosFinal2$RN, dadosFinal$ano_mes),1))
#write.csv2(tab7, "tabela7.csv", row.names = TRUE)
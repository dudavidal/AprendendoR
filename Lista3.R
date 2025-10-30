#Lista 3 - Exerccicios

# O R disponibiliza diversos bancos de dados. 
# Nesta lista trabalharemos com o banco de dados airquality 
airquality

# Questão 1 ----
# Altere o nome de todas as variáveis do banco de dados para o português.

names(airquality) = c("Ozônio","Radiação_Solar", "Vento", "Temperatura","Mês","Dia")
airquality

#Questâo 2 ----
#Extraia o conteúdo da linha 20.

airquality[20,]

# Questão 3 ----
# Substitua no banco de dados airquality o conteúdo da seguinte célula por NA 
# (célula: interseção entre a linha 20 e a coluna com informações sobre o vento).

airquality[20, "Vento"] = NA

# Questão 4 ---
# Considerando inclusive a operação realizada na questão 3, 
# calcule o vento médio do banco de dados.

?mean
mean(airquality$Vento, na.rm = TRUE)

# Questão 5 ---
# Crie uma nova coluna no banco de dados indicando se a temperatura do dia 
# foi maior (retornando TRUE) ou menor ou igual (retornando FALSE) a 75 graus F.

airquality$maiorQue75 = airquality$Temperatura > 75
airquality  

# Questão 6 ---
# Crie um novo banco de dados contendo apenas as informações
# (todas as colunas) dos dias cujas temperaturas foram superiores ao valor definido na questão 5.

novoBanco = airquality[airquality$maiorQue75, ]
novoBanco

#Questões 7 ---
# Transforme o banco de dados da questão 6 em uma matriz e explique 
# porque a coluna criada na questão 5 foi alterada.

matriz = as.matrix(novoBanco)
matriz

# A coluna criada na questão 5 foi alterada porque a matriz só aceita um único tipo de dado.
# Portanto, todas as colunas foram convertidas para o tipo mais geral necessário.


# Questão 8 ---
# Qual é a dimensão da matriz criada na questão 7?

dim(matriz)
# 101,7


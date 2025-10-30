# Lista 1 - Introdução ao R
# Fonte: matéria de Computação em Estatística 1 - UnB
# Objetivo: praticar vetores, matrizes e data frames no R

# Questão 1
# a) Criação do vetor com os 8 primeiros dígitos da matrícula
vetorMatricula = c(2,3,2,0,1,3,2,3)

# b) Criação da matriz 2x4 a partir do vetor
matriz = matrix(vetorMatricula, nrow=2)
matriz

# Questão 2
# a) Sequência de 1 a 40
x = seq(1,40)

# b) Sequência com pares e ímpares
vetorPar = seq(2,40,2)
vetorImpar = seq(1,40,2)
y = c(vetorPar, vetorImpar)

# c) Data frame com x e y
dF = data.frame(x = x, y = y)

# d) Verificar se o ponto (x, y) está dentro do círculo de raio 30
dF$dentroCirculo = (dF$x^2 + dF$y^2) <= 30^2
head(dF)

# Questão 3
# a) Vetor com NA
x = c(10, 20, 30, NA)

# b) Média (gera NA)
mean(x)

# c) Média ignorando o NA
mean(x, na.rm = TRUE)

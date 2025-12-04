#LISTA 6

## QUESTÃO 1

setwd("C:/Users/dudav/Downloads")
banco = read.csv("heart.csv")
head(banco,6)
class(banco)
## QUESTÃo 2

?factor


## QUESTÃO 3/4
library(ggplot2)

ggplot(banco) +
  geom_point(aes(x = age, y = chol, color = sex)) +
  labs(
    x = "Idade",
    y = "Colesterol",
    title = "Idade x Colesterol com Tendência por Sexo",
    color = "Sexo"
  )


#Conclui-se que as mulheres atingem um nível superior

##QUESTÃO 5

tapply(banco$chol,banco$sex,mean,na.rm = TRUE)
tapply(banco$chol,banco$sex,sd)

#O desvio-padrão indicando que os valores de 
# colesterol entre mulheres são mais espalhados ao redor da média.
# tendencia mais alta de colesterol

##QUESTÃO 6

ggplot(banco,aes(x = sex, y = chol,color = sex)) +
  geom_boxplot() + 
  labs(
    title = "sexo Xcolesterol",
    x = "genero",
    y = "colesterol"
  ) + 
  theme_bw()

##QUESTÃO 7

banco[banco$age < 50,]
heart_less_50 = banco[banco$age < 50,]

ggplot(heart_less_50,aes(x=sex,y= chol,color = sex)) + 
  geom_boxplot() + 
  labs(
    title = "Sex X chol menos de 50 anos",
    x = "sex",
    y = "chol"
  ) + 
  theme_bw()

##QUESTÃO 8 

banco = read.csv("heart.csv")
ggplot(banco) +
  geom_segment(aes(x = cp, xend = cp, y = 0, yend = sex))

##QUESTÃO 9

ggplot(banco, aes(x = cp, fill = factor(sex))) +
  geom_bar(position = "fill")

##QUESTÃO 10
ggplot(banco, aes(x = thalach, fill = factor(sex))) +
  geom_histogram(bins = 15, color = "black") +
  facet_wrap(~ sex) +
  scale_fill_manual(values = c("pink", "lightblue"))+
  labs(
    x = "Taxa Máxima de Batimentos (thalach)",
    y = "Frequência",
    title = "Histograma da taxa máxima de batimentos cardíacos por sexo"
  ) +
  theme_minimal()

#QUESTÃO 11
ggplot(banco, aes(x = thalach)) +
  geom_histogram(aes(y = ..density..), bins = 20, fill = "lightblue", color = "black") +
  geom_density(color = "gray30", linewidth = 1.2) +
  facet_wrap(~ sex) +
  labs(
    x = "Taxa Máxima de Batimentos (thalach)",
    y = "Densidade",
    title = "Histograma de densidade da taxa máxima de batimentos por sexo"
  ) +
  theme_minimal()


    
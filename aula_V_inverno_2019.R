##============================================
##
##    Aula 5 - Regressões no R
##
##============================================

## comando para limpar a memória do R ==========================

rm(list = ls())

## abrir pacotes ===============================================

library(tidyverse) # pacote para lidar com os dados
library(car) # pacote com a base "Duncan"
library(ggResidpanel) # pacote para investigar residuos
library(sjPlot) # pacote para calcular magnitude dos efeitos


## abrir base contida no pacote "car" ==========================

duncan <- as.data.frame(Duncan)

## saber nomes da base, tipo e sumário das variáveis ===========

names(duncan)

glimpse(duncan)

summary(duncan)

##===============================================================
## Problema:
## A ideia central é fazer uma predição do salário, segundo o 
## nível de escolaridade.
##===============================================================

## investigar possíveis outliers ================================

boxplot(duncan$income)

# outra forma de fazer o boxplot (ggplot)

duncan %>% 
  ggplot(aes(x = "", y =income)) + 
  geom_boxplot()

# o mesmo com educação

boxplot(duncan$education)

## dar uma olhada na correlação das variáveis =========================

duncan %>% 
  select(income, education) %>% 
  cor(.)

## olhar a curva de regressão =========================================

duncan %>% 
  ggplot(aes(x = income, y = education)) + 
  geom_point() + 
  geom_smooth(method = "lm", se = F)

## rodar a regressão ==================================================

modelo1 <- lm(income ~ education, data = duncan)

summary(modelo1)

resid_panel(modelo1)

resid_panel(modelo1, plots = "qq", qqbands = TRUE)

resid_panel(modelo1, plots = "lev")

resid_interact(modelo1, plots = "lev")

plot_model(modelo1, type = "pred", 
           terms = 'education')


##=====================================================================
## Problema 2: 
## Saber se o número de habitantes afeta o número de homicídios.
##=====================================================================

library(dslabs) # pacote com a base "murders"

data("murders")

## saber nomes da base, tipo e sumário das variáveis ===========

names(murders)

glimpse(murders)

summary(murders)

## investigar possíveis outliers ================================

boxplot(murders$population)

boxplot(murders$total)

## Olhar correlação =============================================

murders %>% 
  select(population, total) %>% 
  cor(.)


## Olhar regressão =============================================

murders %>% 
  ggplot(aes(x = population, y = total)) + 
  geom_point() +
  geom_smooth(method = "lm") +
  theme_bw()


## Rodar modelo ================================================

modelo_2 <- lm(total ~ log(population), data = murders)

summary(modelo_2)


## =============================================
## Exercicio 1:
## Rodar uma regressao com a base "duncan". 
## No modelo, a variavel "prestige" sera nossa
## variavel dependente e "income" e "education"
## nossas variaveis independentes. 
## Verifique possiveis violacoes e "plote" os
## efeitos marginais de nossas duas variaveis 
## independentes. 
## ==============================================

## ==============================================
## Exercicio 2:
## Fique livre para propor um problema com a base
## "BostonHousing". Avalie possiveis violacoes 
## do modelo e "plote" os efeitos marginais 
## da variavel independente. 
## ==============================================

data(BostonHousing)
housing <- BostonHousing

# crim - per capita crime rate by town
# zn - proportion of residential land zoned for lots over 25,000 sq.ft
# indus - proportion of non-retail business acres per town
# chas - Charles River dummy variable (= 1 if tract bounds river; 0 otherwise)
# nox - nitric oxides concentration (parts per 10 million)
# rm - average number of rooms per dwelling
# age - proportion of owner-occupied units built prior to 1940
# dis - weighted distances to five Boston employment centres
# rad - index of accessibility to radial highways
# tax - full-value property-tax rate per USD 10,000
# ptratio- pupil-teacher ratio by town
# b 1000(B - 0.63)^2, where B is the proportion of blacks by town
# lstat - percentage of lower status of the population
# medv - median value of owner-occupied homes in USD 1000’s







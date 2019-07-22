##===========================================
##
##   AULA 1: APRESENTAÇÃO DO RSTUDIO 
##
##===========================================

# apresentar Rstudio (tools, etc.)

# Detalhe: hashtag para comentar

## Comandos básicos =================================

# Ctrl(Command) + Enter para rodar comandos no script

1 + 1

## Operadores Lógicos ===============================

> # maior
< # menor
>= # maior-igual
<= # menor-igual
== # exatamente igual a ....
!= # diferente

### Criar bases =====================================

x <- c(1, 2, 3, 4, 5, 6, 7)
y <- c("Sim", "Nao", "Sim", "Nao", "Sim", "Nao", "Sim")

dados <- data.frame(x, y)

# Detalhe: "c" de "combine", usado para se referir a mais de um valor. 
# Detalhe 2: palavras devem ser envoltas por aspas. 


### Saber o nome das variáveis ======================

names(dados)

### Saber a categoria das variáveis =================

str(dados)

### Sumarizar os dados =============================

summary(dados)

# Outra forma: 

mean(dados$x)
median(dados$x)
sd(dados$x)
quantile(dados$x)


### Tabular os dados (usado para categóricas) ================

# números absolutos
table(dados$y)

# porcentagens
prop.table(table(dados$y))


### Pacotes ===================================================

# install.packages("nome_do_pacote")

# library(nome_do_pacote)

# Exemplo 

install.packages("dplyr", dependencies = TRUE) # basta instalar uma vez. 

library(dplyr) # tem que rodar o pacote toda vez

update.packages() # atualizar pacotes (fazer de vez em quando)


### Atalhos importantes ========================================

# ctrl(cmd) + shift + C = comentários

# alt + - = criar objeto

# ctrl(cmd) + shift + H = setwd() = acertar o diretório

# ctrl(cmd) + D = apaga a linha

# ctrl(cmd) + shift + m = pipe (importante para tidyverse)

# tab = completar o nome sugerido pelo Rstudio 


### Exemplos de análise ======================================

# Como o R performa

getwd() # saber o diretório de trabalho

dir() # para saber o que tem no diretório 

setwd() # ou ctrl + shift + H



### Aprovação do aborto no WVS ======================================

# site: http://www.worldvaluessurvey.org/WVSDocumentationWV6.jsp

# nome da variável no banco: V204

# install.packages(c("tidyverse", "haven", "janitor", "formattable",
#                    "hrbrthemes", "ggthemes"))

library(tidyverse) # pacote base para mexer no R
library(janitor) # pacote para tirar tabulações 
library(rio) # pacote para abrir bases

install_formats() # instalar formatos diferentes

# mudar diretório para achar base

# primeira forma

setwd("/Volumes/GoogleDrive/My Drive/escola_inverno/escola_inverno_2019")

# ctrl(também no mac) + shift + H 

# dir() # saber como está o nome do arquivo no diretório
dir()

getwd()

setwd()

dir()

lapop_14 <- import("lapop_2014.sav")

names(lapop_14) # saber os nomes das variáveis

glimpse(lapop_14) # saber tipos das variáveis

# Frequências simples

lapop_14 <- lapop_14 %>% 
  rename(aborto = w14a, 
         sexo = sexi) 

lapop_14 <- lapop_14 %>% 
  select(aborto, sexo)

lapop_14 %>% 
  tabyl(aborto) 

# Diferenca aborto x sexo

lapop_14 %>% 
  tabyl(sexo, aborto) 

lapop_14 %>% 
  tabyl(sexo, aborto) %>% 
  adorn_crosstab()

# salvar analise na pasta 

aborto <- lapop_14 %>% 
  tabyl(sexo, aborto) %>% 
  adorn_crosstab()

write_csv(aborto, "aborto.csv")

## ======================================
## Exercicio 1:
## 1) Abrir o LAPOP,
## 2) Renomear a variavel "brawrs1" 
## para "pbf" e "sexi" para "sexo"
## 3) Selecionar as duas variaveis e
## criar uma nova base
## 4) Tabular a variavel pbf
## 5) Ver a diferenca percentual de pbf 
## dado o sexo dos respondentes
## 6) Salvar a analise em ".csv"
## =====================================





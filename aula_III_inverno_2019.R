## ==================================================
##
##       Aula 3 - Sumarios e Palavras (strings)
##
## ==================================================

# Nas aulas passadas, além de manipular bases e colunas, 
# aprendemos a mexer em linhas com as funcoes "mutate"
# e "filter".

# Vimos que a funcao "mutate" normalmente precisa de 
# funcoes suplementares como o "ifelse" e o "case_when".
# Qual a diferenca entre os dois?

# Hoje, aprofundaremos os sumarios estatísticos das 
# variaveis continuas. Ate entao, estavamos trabalhando
# basicamente com variaveis categoricas, mais comuns
# nas ciencias humanas. 

# Para tal, abriremos uma base contida no pacote 
# "gapminder".

library(gapminder)
library(tidyverse)
library(janitor)

options(scipen = 999)

gapminder <- gapminder

# Como saber o nome das variaveis?

names(gapminder)

# Como saber o tipo das variaveis?

glimpse(gapminder)

# Como sumarizar as variaveis?

summary(gapminder)

# Para contar o número de países

gapminder %>% 
  filter(!duplicated(country))

# Ok, mas e se quisermos olhar as diferencas 
# entre continentes e paises? Para tanto, temos
# que usar uma combinacao entre "group_by" e 
# "summarise". Exemplo:

gapminder %>% 
  group_by(continent) %>% 
  summarise(media_cont = mean(lifeExp))

# Se tivermos NAs em algumas das variaveis, temos
# que incluir a funcao "na.rm = TRUE".

gapminder %>% 
  group_by(continent) %>% 
  summarise(media_cont = mean(lifeExp, na.rm = TRUE))

# Para ordenar os dados, usamos a funcao "arrange".

gapminder %>% 
  group_by(continent) %>% 
  summarise(media_cont = mean(lifeExp)) %>% 
  arrange(-media_cont)

# ou 

gapminder %>% 
  group_by(continent) %>% 
  summarise(media_cont = mean(lifeExp)) %>% 
  arrange(media_cont)

# Como eu faria para ver as diferencas entre 
# paises?

gapminder %>% 
  group_by(country) %>% 
  summarise(media_country = mean(lifeExp)) %>% 
  arrange(-media_country)


gapminder %>% 
  group_by(country) %>% 
  summarise(media_pais = mean(lifeExp))

# Como eu faco para ordenar essas diferencas?

gapminder %>% 
  group_by(country) %>% 
  summarise(media_pais = mean(lifeExp)) %>% 
  arrange(-media_pais)


# Assim como a media, outras estatisticas podem
# ser tiradas da mesma maneira.

gapminder %>% 
  group_by(continent) %>% 
  summarise(mediana = median(lifeExp))


# ou

gapminder %>% 
  group_by(continent) %>% 
  summarise(mediana = median(lifeExp),
            desvio_padrao = sd(lifeExp))

# Alem disso, podemos tirar as estatisticas de 
# uma ou mais variaveis com derivacoes do "summarise".
# Veja o exemplo abaixo com o "summarise_at".

gapminder %>% 
  summarise_at(vars(lifeExp, pop), mean)

# E se eu quiser comparar a media de expectativa de 
# vida de Brasil e Cuba, como devo fazer?

gapminder %>%
  filter(country == "Brazil" | country == "Cuba") %>% 
  group_by(country) %>% 
  summarise(media_country = mean(lifeExp))


gapminder %>% 
  filter(country %in% c("Brazil", "Cuba")) %>% 
  group_by(country) %>% 
  summarise_at(vars(lifeExp, pop), mean)
  
# E seu eu quiser comparar somente o ultimo ano da
# expectativa de vida de Brasil e Canada?

gapminder %>% 
  filter(country %in% c("Brazil", "Canada"), 
         year == 2007) %>% 
  select(populacao = pop, everything())

gapminder %>% 
  filter(country %in% c("Brazil", "Canada") & year == 2007)


# A funcao "tabyl", do pacote "janitor" facilita
# a tabulacao de variaveis categoricas. Mas o mesmo
# pode ser feito com o "summarise".

gapminder %>% 
  tabyl(continent)

# ou ...

gapminder %>%
  group_by(continent) %>% 
  summarise(n = n()) %>% 
  mutate(percent = n/sum(n))


## Palavras (strings) no R =========================

# Vou fazer uma breve introducao a manipulacao de 
# palavras no R, mas isso é parte do curso do Saulo
# (text mining). 

# Para tanto, vou abrir a base do IMDB. A base foi
# raspada do site: http://www.imdb.com/chart/top.

library(rio)

base_imdb <- import("base_imdb.csv")

# Saber os nomes?

names(base_imdb)

# Saber os tipos?

glimpse(base_imdb)

# Legal, agora vou passar todos os tipos para 
# letras minusculas. 

base_imdb

base_imdb %>% 
  mutate(titulos = str_to_lower(titulos))

# agora para maiusculas

base_imdb %>% 
  mutate(titulos = str_to_upper(titulos))

# agora vou tirar o acento agudo de i

base_imdb %>% 
  mutate(titulos = str_to_lower(titulos)) %>% 
  mutate(titulos = str_replace_all(titulos, "í", "i"))


# agora vou filtrar somente os filmes do Batman

base_imdb %>% 
  mutate(titulos = str_to_lower(titulos)) %>% 
  filter(str_detect(.$titulos, "batman"))


# Exercício 

# 1)  Ver quais os 5 países que tiveram o maior GDP Per Capita em 2007
# 2)  Filtrar o Gapminder pelo Brasil e esses países após o ano 2000
# 3)  Passar o nome dos países pra maiúsculas
# 3)  Sumarizar a média do gdpPercap por país 
# 4)  Ordenar do maior pro menor
# 5)  Salvar a análise em .csv

  












































# Aula 2 ------------
# Uso de pacotes
setwd("~/Documentos/minucurso R")
dir()
# =============================================================================
# 1. CARREGAMENTO DE PACOTES E DADOS
# =============================================================================ççç
# chama o pacote

if (!require("ggplot2")) install.packages("ggplot2")
library("ggplot2")

if (!require("pacman")) install.packages("pacman")
library(pacman)

#tidyverse é um pacotão que vem com dplyr,ggplot2,tidyr
#geobr fornece limites territoriais do braasil
#sf manipulação e analise de dados geospaciais
#stringi manipular texto
#scale formatar grafos

# Carrega todos os pacotes e se necessário, instala
p_load(tidyverse, gt, geobr, stringi, sf, scales)

# Importa os dados - ajuste o caminho conforme necessário
dados_24 <- read.csv2("CGIL_CNIg_2024.csv",
                      sep=";",fileEncoding = "UTF-8")
dados_25 <- read.csv2("CGIL_CNIg_jan-set2025.csv",
                      sep=";",fileEncoding = "UTF-8")
0# Juntandos os dados
df <- rbind(dados_24, dados_25)

#Funções para explorar o Data Frame

# View(df) - ve a tabela
# head(df) - ve o inicio 
# summary(df) - resumos estaticos
# options(scipen = 9999) - tirar a notação cientifica
# str(df) - estrutura de dados


# -----------------------------------------------------------------------------
# ANÁLISE DE GÊNERO - Gráfico de Barras
# -----------------------------------------------------------------------------


# Verificando a frequência da variável genêro

# 1. Versão R Base - garfico que vem do R

# Gráfico de barras simples
# table(df$genero) cria uma tabela de frequência da variável gênero
barplot(table(df$genero), # table da a frequência
        main = "Distribuição por Gênero",  # Título do gráfico
        xlab = "Gênero",                   # eixo X
        ylab = "Frequência",               # eixo Y  
        col = "pink")                 # pode botar o nome da cor ou a # se for uma especifica

# 2.ggplot padrão

ggplot(data = df, aes(x = genero)) + # aes = aesthetics, define variável no eixo X
  geom_bar() +              # tipo de grafico 
  labs(title = "Frequência de Genêro",          
       x = "Gênero",        # Rótulo eixo X
       y = "Frequência")+   # Rótulo eixo
      theme_minimal()
#3. Versão ggplot personalizado 

# Primeiro calculamos estatísticas antes de plotar para maior eficiência
# pois o primeiro data frame nao tem a frequencia

library(dplyr)
df_summary_gen <- df %>%               # 1. Pega o data frame df e mande ele para o próximo comando
  count(genero) %>%                    # 2. Conta quantas vezes cada gênero aparece (gera colunas genero e n)
  mutate(
    porcentagem = n / sum(n) * 100,    # 3. Calcule a porcentagem de cada categoria
    porcentagem = paste0(round(porcentagem, 1), "%") # 4. Transforme em texto com o símbolo %
  )

df_summary_gen
# tabela de genero - frequência - porcentagem

ggplot(df_summary_gen, aes(x = reorder(genero,-n), y = n)) +
  geom_col(fill = "pink") + 
  geom_text(aes(label = porcentagem), 
            vjust = -0.5, # Posiciona texto 
            size = 2.5) + # Tamanho da fonte 
  labs(title = "Frequência gênero", # Título do gráfico
       x = "Gênero", # eixo X
       y = "Número de pessoas") + # eixo Y 
  theme_classic() # Tema     

ggplot(df_summary_gen, aes(x = reorder(genero,-n), y = n)) +
  geom_col(fill = "red") + 
  geom_text(aes(label = n), # o que aparece em cima
            vjust = 2, # Posiciona texto 
            size = 5 + # Tamanho da fonte 
  labs(title = "Frequência gênero", # Título do gráfico
       x = "Gênero", # eixo X
       y = "Número de pessoas") + # eixo Y 
  theme_classic() # Tema     



#roda os dados da aula 1 -----------------------------------------------------

df$data_nascimento <- as.Date(df$data_nascimento)
data_ref <- as.Date(paste(df$ano, df$mes, "01", sep = "-")) #referência para calcular a idade

df$idade <- floor(difftime(data_ref, df$data_nascimento, unit = "days")/365.25)

df$faixa_etaria[df$idade < 15] <- NA
df$faixa_etaria[df$idade >= 15 & df$idade < 20] <- "Menor que 20" #16 ais 19 
df$faixa_etaria[df$idade >= 20 & df$idade <= 34] <- "20-34"
df$faixa_etaria[df$idade >= 35 & df$idade <= 49] <- "35-49"
df$faixa_etaria[df$idade >= 50 & df$idade <= 64] <- "50-64"
df$faixa_etaria[df$idade >= 65] <- "65 ou mais"

ggplot(df, aes(x = faixa_etaria) +geom_bar()

ordem_faixas <- c("Menor que 20", "20-34", "35-49", "50-64", "65 ou mais")
df$faixa_etaria <- factor(df$faixa_etaria, levels = ordem_faixas)

#limpar os dados qeu podem ter erros
df %>%
  filter(!is.na(faixa_etaria)) %>%  #quem nâo é NA é removido ou seja quem tem menos de 15 
  ggplot(aes(x = faixa_etaria)) +
  geom_bar(fill = "pink") +  
  labs(x = "Faixa Etária",      # Rótulo do eixo X
       y = "Frequência") +      # Rótulo do eixo Y
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# ANÁLISE DE DUAS VARIAVEIS JUNTAS


# Aula mais rodada
#Criar uma ordem hierárquica da escolaridade, do menor para o maior.

df$escolaridade[df$escolaridade == "Analfabeto"] = "1_Analfabeto"
df$escolaridade[df$escolaridade == "Doutorado"] = "8_Doutorado"
df$escolaridade[df$escolaridade == "Mestrado"] = "7_Mestrado" 
df$escolaridade[df$escolaridade == "Especialização"] = "6_Pós-Graduação"
df$escolaridade[df$escolaridade == "Fundamental Completo"] = "3_Fundamental"
df$escolaridade[df$escolaridade == "Fundamental Incompleto"] = "2_Fundamental Incompleto"
df$escolaridade[df$escolaridade == "Médio Completo"] = "4_Médio"
df$escolaridade[df$escolaridade == "Médio Incompleto"] = "3_Fundamental"
df$escolaridade[df$escolaridade == "Pós-doutorado"] = "8_Doutorado"
df$escolaridade[df$escolaridade == "Superior Completo"] = "5_Superior"
df$escolaridade[df$escolaridade == "Superior Incompleto"] = "4_Médio"

top_ocupacoes_pct <- df %>%
  count(escolaridade, codigo_cbo, descricao_cbo) %>%  #contar escolaridade, codigo e descrição
  group_by(escolaridade) %>%      
  mutate(
    total_escolaridade = sum(n), 
    porcentagem = n / total_escolaridade * 100  
  ) %>%
  slice_max(n, n = 5) %>% 
  ungroup() %>%         
  mutate(
    descricao_curta = substr(descricao_cbo, 1, 40)  
  )



# CRIAR GRÁFICO DE BARRAS --------------------------

ggplot(top_ocupacoes_pct, aes(x = porcentagem, y = descricao_curta)) +
  geom_col(aes(fill = escolaridade)) +  # Barras coloridas por escolaridade
  facet_wrap(~ escolaridade, scales = "free_y", ncol = 2) +
  labs(
    x = "Porcentagem dentro da Escolaridade (%)",     #  eixo X
    y = ""                                            #  eixo Y vazio
  ) +
  scale_x_continuous(labels = scales::percent_format(scale = 1)) +  
  theme(legend.position = "none")

# ANÁLISE BIVARIADA - Gênero vs Andamento

## - Inclusão da 2° variável (análise bivariada)

# PREPARA DADOS AGRUPADOS
# Filtra apenas dados de 2025 e calcula estatísticas por gênero e andamento
df_andamento_genero <- df %>% 
  filter(ano == 2025) %>% # Filtra apenas o ano de 2025
  group_by(andamento, genero) %>% # Agrupa por tipo de andamento e gênero
  summarise(n = n()) %>%  # Conta número de casos em cada combinação
  group_by(genero) %>% # Reagrupa apenas por gênero
  mutate(
    porcentagem = n / sum(n) * 100, # Calcula porcentagem dentro de cada gênero
    label = paste0(round(porcentagem,2), "%") # Cria rótulo formatado para o gráfico
  )

# OPÇÃO 1:
# Mostra comparação direta dos valores absolutos entre gêneros

ggplot(df_andamento_genero, aes(x = genero, y = n, fill = andamento)) +
  geom_bar(stat = "identity", position = "dodge") +  
  labs( y = "Número de Pessoas", # Eixo Y: contagem absoluta
        x = "Gênero",      # Eixo X: categorias de gênero
        fill = "Andamento") # Legenda: tipos de andamento  

# OPÇÃO 2: BARRAS EMPILHADAS COM PORCENTAGEM
# Mostra distribuição percentual dentro de cada gênero
ggplot(df_andamento_genero, aes(x = genero, y = porcentagem, fill = andamento)) +
  geom_bar(stat = "identity", position = "stack") +  # Barras empilhadas (stack)
  geom_text(aes(label = label), # Adiciona rótulos com porcentagens
            position = position_stack(vjust = 0.5),  # Posiciona texto no meio das barras
            size = 3) +    # Tamanho do texto
  labs(title = "Distribuição Percentual por Gênero",
       y = "Porcentagem (%)",   # Eixo Y: porcentagem
       x = "Gênero",            # Eixo X: categorias de gênero
       fill = "Andamento") +
    scale_fill_manual(
      "CANCELAMENTO DE PROCESSO" = "Pink"
      
    )

# -----------------------------------------------------------------------------
# ANÁLISE DE PAÍSES DE ORIGEM
# -----------------------------------------------------------------------------

# TOP 15 PAÍSES MAIS FREQUENTES
# Calcula a frequência e porcentagem de cada país no dataset

df_summary_pais <- df %>% 
  count(pais) %>% 
  mutate(
    porcentagem = n / sum(n) * 100,
    label = paste0(round(porcentagem, 1), "%")  
  ) %>% 
  arrange(desc(n)) %>% 
  head(15)  

# GRÁFICO DE BARRAS HORIZONTAIS
# Usa gráfico horizontal para melhor visualização dos nomes dos países
ggplot(df_summary_pais, aes(x = reorder(pais, n), y = n)) + 
geom_col(fill = "pink) +    # Barras na cor azul escuro
  coord_flip() +                  # Inverte eixos para deixar barras horizontais
  geom_text(aes(label = label),   # Adiciona rótulos com as porcentagens
            hjust = -0.1,         # Posiciona texto à direita das barras
            size = 3) +           # Define tamanho da fonte
  labs(x = "",                    # Eixo X vazio (países ficam no eixo Y após coord_flip)
       y = "Número de pessoas") 




# ANÁLISE EXTRA: Distribuição das taxas de deferimento dos países de origem 
# por faixas de num. de solicitação

# CALCULAR TAXAS DE DEFERIMENTO POR PAÍS
df_taxa_pais <- df %>% filter(ano == 2025) %>% 
  group_by(pais, andamento) %>%   # Agrupa por país e tipo de andamento
  summarise(n = n(), .groups = "drop") %>%  # Conta casos, remove agrupamento
  pivot_wider(
    names_from = andamento,   # Transforma andamento em colunas
    values_from = n,          # Valores vêm da contagem
    values_fill = 0           # Preenche NAs com 0
  ) %>%
  mutate(
    solicitacoes = rowSums(across(where(is.numeric))),  # Total de solicitações por país
    taxa_deferido = DEFERIDO / solicitacoes,  # Calcula taxa de deferimento
    taxa_ideferido = INDEFERIDO / solicitacoes  # Calcula taxa de indeferimento
  ) %>% 
  arrange(desc(taxa_deferido)) # Ordena por taxa de deferimento (maior primeiro)

# ANALISAR DISTRIBUIÇÃO DO NÚMERO DE SOLICITAÇÕES POR PAÍS
summary(df_taxa_pais$solicitacoes)   # Mostra quartis, mediana, média, etc.

# CRIANDO FAIXAS DE SOLICITAÇÕES BASEADAS NOS QUARTIS:
# 1 a 4     (primeiro quartil)
# 5 a 20    (segundo quartil)  
# 21 a 115  (terceiro quartil)
# maior que 115 (quarto quartil)

df_taxa_pais$faixa_solicitacao <- case_when(
  df_taxa_pais$solicitacoes <= 4 ~ "Até 04 solicitações",
  df_taxa_pais$solicitacoes > 4 & 
    df_taxa_pais$solicitacoes <= 20 ~ "Entre 05 e 20 solicitações",
  df_taxa_pais$solicitacoes > 20 & 
    df_taxa_pais$solicitacoes <= 115 ~ "Entre 21 e 115 solicitações",
  df_taxa_pais$solicitacoes > 115 ~ "Maior que 115 solicitações"
)

# GRÁFICO DE BOXPLOT DA TAXA DE DEFERIMENTO POR FAIXA DE SOLICITAÇÃO
ggplot(df_taxa_pais, 
       aes(x = faixa_solicitacao, y = taxa_deferido)) +
  geom_boxplot(fill = "#284b63", alpha = 0.7) +      # Boxplot com cor e transparência
  labs(x = "Faixa de solicitação",                  
       y = "Taxa de deferimento")




# =============================================================================
# 2.1 NÚMERO DE DEFERIMENTOS AO LONGO DO TEMPO - Gráfico de Linhas
# =============================================================================


# Agrupa dados por ano e mês, criando variável de data formatada
df_serie <- df %>% 
  count(ano, mes) %>% # Conta processos por ano e mês
  mutate(
    data = as.Date(paste(ano, mes, "01", sep = "-"))# Cria data no formato AAA-MM-DD
  )  # Usa "01" como dia padrão para primeiro do mês


ggplot(df_serie, aes(x = data, y = n, group = 1)) + # group=1 conecta pontos em série
  geom_line(color = "pink", linewidth = 1) + # Linha principal da série
  geom_point(color = "pink", size = 2) + # Pontos sobre a linha
  scale_x_date(
    date_labels = "%b/%Y",  # Formata datas como "Jan/2024"
    date_breaks = "1 month" # Quebra do eixo a cada mês
  ) +
  # scale_y_continuous(
  #   breaks = seq(0, max(df_serie$n, na.rm = TRUE), by = 500)  # Escala Y de 500 em 500
  # ) +
  labs(
    x = "Mês/Ano",                 # Rótulo eixo X
    y = "Número de deferimentos",  # Rótulo eixo Y
    subtitle = "Período 2024–2025" # Subtítulo
  ) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1)  # Inclina labels do eixo X 45°
  )


# VISUALIZAÇÃO GEOGRÁFICA - Distribuição por UF


# PREPARAR DADOS: Contar imigrantes deferidos por UF em 2025
df_summary_uf <- df %>% 
  filter(andamento == "DEFERIDO", ano == 2025) %>%  # Filtra apenas deferimentos de 2025
  count(uf_estrangeiro, name = "n_imigrantes")      # Conta por UF

install.packages("geobr")
library(geobr)
datasets = list.geobr()
View(datasets)
# CARREGAR MAPA DO BRASIL: Obter shapes dos estados brasileiros
# Esse objeto tem o formato sf (Simple Features), com polígonos de cada UF
mapa_brasil_uf <- read_state(showProgress = T, year = 2020)  # Carrega mapa dos estados

# UNIFORMIZANDO OS CARACTERES DOS ESTADOS - Padronizar nomes para fazer o merge

# Padroniza nomes no mapa: remove acentos e converte para maiúsculas
mapa_brasil_uf$name_state <- mapa_brasil_uf$name_state %>%
  iconv(from = "UTF-8", to = "ASCII//TRANSLIT") %>%  # Remove acentos
  toupper()                                          # Transforma para caixa alta

# Padroniza nomes nos dados: remove acentos e converte para maiúsculas  
df_summary_uf$uf_estrangeiro <- df_summary_uf$uf_estrangeiro %>%
  iconv(from = "UTF-8", to = "ASCII//TRANSLIT") %>%  # Remove acentos
  toupper()                                          # Transforma para caixa alta

# COMBINAR DADOS COM MAPA: Juntar informações de imigrantes com shapes dos estados
mapa_uf <- merge(
  x = df_summary_uf,                  # Dados com contagem de imigrantes
  y = mapa_brasil_uf,                 # Shapes dos estados
  by.x = "uf_estrangeiro",            # Coluna de união nos dados
  by.y = "name_state",                # Coluna de união no mapa
  all.x = TRUE                       # Mantém todos os estados dos dados
)

# 1. ESBOÇO DO MAPA BASE - Visualização inicial sem dados
ggplot(mapa_brasil_uf) +
  geom_sf(fill = "#457b9d", color = "white") +  # Desenha estados com cor uniforme
  theme_void()                                  # Remove todos os elementos do tema

# 2. MAPA TEMÁTICO - Adicionar as informações de número de imigrantes
mapa_uf <- st_as_sf(mapa_uf)                   # Garante que é objeto sf (Simple Features)

# Cria mapa coroplético (cores proporcionais aos valores)
ggplot(mapa_uf) +
  geom_sf(aes(fill = n_imigrantes),            # Preenche por número de imigrantes
          color = "white", size = 0.2) +       # Bordas brancas finas
  scale_fill_viridis_c(
    option = "plasma",                         # Escala de cores "plasma"
    trans = "log10",                           # Transformação logarítmica (melhor visualização)
    name = "Nº de Imigrantes (escala log)",    # Título da legenda
    labels = scales::number_format(accuracy = 1)  # Formata rótulos da legenda
  ) +
  theme_minimal() +
  labs(
    title = "",
    subtitle = "",
    caption = ""
  ) +
  theme(
    axis.text = element_blank(),    # Remove textos dos eixos
    axis.ticks = element_blank(),   # Remove marcadores dos eixos  
    panel.grid = element_blank()    # Remove grade do fundo
    )
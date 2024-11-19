CREATE TABLE PESSOA(
CPF CHAR(14) NOT NULL,
TIPO CHAR(6) NOT NULL,
CONSTRAINT PK_PESSOA PRIMARY KEY(CPF),
CONSTRAINT CK_TIPO_PESSOA CHECK(UPPER(TIPO) IN('MENTOR','ATLETA')),
CONSTRAINT CK_CPF CHECK(REGEXP_LIKE(CPF, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}'))
);

CREATE TABLE MENTOR(
PESSOA CHAR(14) NOT NULL,
NOME VARCHAR2(25),
INICIO_DE_CARREIRA DATE NOT NULL,
FIM_DE_CARREIRA DATE,
DATA_NASC DATE,
ESCOLARIDADE VARCHAR2(17),
NUM_TELEFONE CHAR(15),
PAIS VARCHAR2(20),
ESTADO CHAR(2),
CIDADE VARCHAR2(60),
LOGRADOURO VARCHAR2(60),
NUMERO NUMBER,
COMPLEMENTO VARCHAR2(10),



CONSTRAINT PK_MENTOR PRIMARY KEY(PESSOA),
CONSTRAINT FK_MENTOR_PESSOA FOREIGN KEY(PESSOA) REFERENCES PESSOA(CPF) ON DELETE CASCADE,
CONSTRAINT CK_MENTOR_CPF CHECK(REGEXP_LIKE(PESSOA, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}')),
CONSTRAINT CK_NUM_TELEFONE_MENTOR CHECK(REGEXP_LIKE(NUM_TELEFONE,'\(\d\d\d\)\d\d\d\d\d-\d\d\d\d')),
CONSTRAINT CK_ESCOLARIDADE_MENTOR CHECK(ESCOLARIDADE IN('EDUCACAO INFANTIL','FUNDAMENTAL','MEDIO','SUPERIOR','PÓS-GRADUAÇÃO','MESTRADO','DOUTORADO', 'PÓS-DOUTORADO'))
);

CREATE TABLE ATLETA(
PESSOA CHAR(14) NOT NULL,
CLUBE_OU_EQUIPE VARCHAR2(20) NOT NULL,
NOME VARCHAR2(25),
MENTOR CHAR(14) NOT NULL,
DATA_NASC DATE,
ESCOLARIDADE VARCHAR2(17),
NUM_TELEFONE CHAR(15),
PAIS VARCHAR2(20),
ESTADO CHAR(2),
CIDADE VARCHAR2(60),
LOGRADOURO VARCHAR2(60),
NUMERO NUMBER,
COMPLEMENTO VARCHAR2(10),



CONSTRAINT PK_ATLETA PRIMARY KEY(PESSOA),
CONSTRAINT FK_ATLETA_PESSOA FOREIGN KEY(PESSOA) REFERENCES PESSOA(CPF) ON DELETE CASCADE,
CONSTRAINT FK_ATLETA_MENTOR FOREIGN KEY(MENTOR) REFERENCES MENTOR(PESSOA) ON DELETE CASCADE,
CONSTRAINT CK_ATLETA_CPF CHECK(REGEXP_LIKE(PESSOA, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}')),
CONSTRAINT CK_NUM_TELEFONE_ATLETA CHECK(REGEXP_LIKE(NUM_TELEFONE,'\(\d\d\d\)\d\d\d\d\d-\d\d\d\d')),
CONSTRAINT CK_ESCOLARIDADE_ATLETA CHECK(ESCOLARIDADE IN('EDUCACAO INFANTIL','FUNDAMENTAL','MEDIO','SUPERIOR','PÓS-GRADUAÇÃO','MESTRADO','DOUTORADO', 'PÓS-DOUTORADO'))
);

CREATE TABLE ALERGIAS_ATLETA(
ATLETA CHAR(14) NOT NULL,
ALERGIA VARCHAR2(20) NOT NULL,

CONSTRAINT PK_ALERGIAS_ATLETA PRIMARY KEY (ATLETA,ALERGIA),
CONSTRAINT FK_ALERGIAS_ATLETA FOREIGN KEY (ATLETA) REFERENCES ATLETA(PESSOA) ON DELETE CASCADE,
CONSTRAINT CK_ALERGIAS_ATLETA_CPF CHECK(REGEXP_LIKE(ATLETA, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}'))
);

CREATE TABLE ALERGIAS_MENTOR(
MENTOR CHAR(14) NOT NULL,
ALERGIA VARCHAR2(20) NOT NULL,

CONSTRAINT PK_ALERGIAS_MENTOR PRIMARY KEY (MENTOR,ALERGIA),
CONSTRAINT FK_ALERGIAS_MENTOR FOREIGN KEY (MENTOR) REFERENCES MENTOR(PESSOA) ON DELETE CASCADE,
CONSTRAINT CK_ALERGIAS_MENTOR_CPF CHECK(REGEXP_LIKE(MENTOR, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}'))
);

CREATE TABLE DOENCAS_ATLETA(
ATLETA CHAR(14) NOT NULL,
DOENCA VARCHAR2(20) NOT NULL,

CONSTRAINT PK_DOENCAS_ATLETA PRIMARY KEY (ATLETA,DOENCA),
CONSTRAINT FK_DOENCAS_ATLETA FOREIGN KEY (ATLETA) REFERENCES ATLETA(PESSOA) ON DELETE CASCADE,
CONSTRAINT CK_DOENCAS_ATLETA_CPF CHECK(REGEXP_LIKE(ATLETA, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}'))
);


CREATE TABLE DOENCAS_MENTOR(
MENTOR CHAR(14) NOT NULL,
DOENCA VARCHAR2(20) NOT NULL,

CONSTRAINT PK_DOENCAS_MENTOR PRIMARY KEY (MENTOR,DOENCA),
CONSTRAINT FK_DOENCAS_MENTOR FOREIGN KEY (MENTOR) REFERENCES MENTOR(PESSOA) ON DELETE CASCADE,
CONSTRAINT CK_DOENCAS_MENTOR_CPF CHECK(REGEXP_LIKE(MENTOR, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}'))
);

CREATE TABLE OBJETIVO_DE_DESENVOLVIMENTO(
ATLETA CHAR(14) NOT NULL,
NUM_OBJETIVO NUMBER NOT NULL,
DESCRICAO VARCHAR2(500),
STATUS VARCHAR2(20),

CONSTRAINT PK_OBJETIVO_DE_DESENVOLVIMENTO PRIMARY KEY(ATLETA,NUM_OBJETIVO),
CONSTRAINT FK_OBJETIVO_DE_DESENVOLVIMENTO FOREIGN KEY (ATLETA) REFERENCES ATLETA(PESSOA) ON DELETE CASCADE,
CONSTRAINT CK_OBJETIVO_DE_DESENVOLVIMENTO_ATLETA_CPF CHECK(REGEXP_LIKE(ATLETA, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}')),
CONSTRAINT CK_STATUS_OBJETIVO_DE_DESENVOLVIMENTO CHECK(STATUS IN('CONCLUIDO','ABANDONADO','EM PROGRESSO'))
);

CREATE TABLE RECORDES(
MODALIDADE VARCHAR2(12) NOT NULL,
DATA DATE NOT NULL, 
INFORMACAO VARCHAR2(30),

CONSTRAINT PK_RECORDES PRIMARY KEY (MODALIDADE,DATA)
);

CREATE TABLE RECORDES_DETIDOS(
MODALIDADE VARCHAR2(12) NOT NULL,
DATA DATE NOT NULL,
ATLETA CHAR(14) NOT NULL,

CONSTRAINT PK_RECORDES_DETIDOS PRIMARY KEY (MODALIDADE,DATA,ATLETA),
CONSTRAINT FK_RECORDES_DETIDOS_RECORDES FOREIGN KEY (MODALIDADE,DATA) REFERENCES RECORDES(MODALIDADE,DATA) ON DELETE CASCADE,
CONSTRAINT FK_RECORDES_DETIDOS_ATLETAS FOREIGN KEY (ATLETA) REFERENCES ATLETA(PESSOA) ON DELETE CASCADE,
CONSTRAINT CK_RECORDES_DETIDOS_ATLETA_CPF CHECK(REGEXP_LIKE(ATLETA, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}'))

);

CREATE TABLE LOCAL_DE_TREINO(
NOME_DO_ESPACO VARCHAR2(20) NOT NULL,
PAIS VARCHAR2(20) NOT NULL,
ESTADO CHAR(2) NOT NULL,
CIDADE VARCHAR2(60) NOT NULL,
LOGRADOURO VARCHAR2(60) NOT NULL,
NUMERO NUMBER NOT NULL,
COMPLEMENTO VARCHAR2(10),

CONSTRAINT PK_LOCAL_DE_TREINO PRIMARY KEY (NOME_DO_ESPACO)
);

CREATE TABLE EQUIPAMENTOS_DE_TREINO(
LOCAL_DE_TREINO VARCHAR2(20) NOT NULL,
EQUIPAMENTO VARCHAR2(12) NOT NULL,

CONSTRAINT PK_EQUIPAMENTOS_DE_TREINO PRIMARY KEY (LOCAL_DE_TREINO,EQUIPAMENTO),
CONSTRAINT FK_EQUIPAMENTOS_DE_TREINO_LOCAL_DE_TREINO FOREIGN KEY (LOCAL_DE_TREINO) REFERENCES LOCAL_DE_TREINO(NOME_DO_ESPACO) ON DELETE CASCADE
);

CREATE TABLE SESSAO_DE_MENTORIA(
ATLETA CHAR(14) NOT NULL,
DATA DATE NOT NULL,
TOPICO VARCHAR2(20),
EXERCICIO VARCHAR2(15),
ACOMPANHAMENTO_DE_PROGRESSO VARCHAR2(30),
LOCAL_DE_TREINO VARCHAR2(20) NOT NULL,

CONSTRAINT PK_SESSAO_DE_MENTORIA PRIMARY KEY (ATLETA,DATA),
CONSTRAINT FK_SESSAO_DE_MENTORIA_ATLETA FOREIGN KEY (ATLETA) REFERENCES ATLETA(PESSOA) ON DELETE CASCADE,
CONSTRAINT FK_SESSAO_DE_MENTORIA_LOCAL_DE_TREINO FOREIGN KEY (LOCAL_DE_TREINO) REFERENCES LOCAL_DE_TREINO(NOME_DO_ESPACO) ON DELETE CASCADE,
CONSTRAINT CK_SESSAO_DE_MENTORIA_ATLETA_CPF CHECK(REGEXP_LIKE(ATLETA, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}'))

);

CREATE TABLE ESPORTES_PRATICADOS(
ATLETA CHAR(14),
NOME_DO_ESPORTE VARCHAR2(15),
CATEGORIA_DO_ESPORTE VARCHAR2(15),

CONSTRAINT PK_ESPORTES_PRATICADOS PRIMARY KEY (ATLETA,NOME_DO_ESPORTE,CATEGORIA_DO_ESPORTE),
CONSTRAINT FK_ESPORTES_PRATICADOS_ATLETA FOREIGN KEY (ATLETA) REFERENCES ATLETA(PESSOA) ON DELETE CASCADE,

CONSTRAINT CK_ESPORTES_PRATICADOS_ATLETA_CPF CHECK(REGEXP_LIKE(ATLETA, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}'))
);

CREATE TABLE EVENTO(
NOME_DO_EVENTO VARCHAR2(20) NOT NULL,
DATA_EVENTO DATE NOT NULL,
PAIS VARCHAR2(20) NOT NULL,
ESTADO CHAR(2) NOT NULL,
CIDADE VARCHAR2(60) NOT NULL,
LOGRADOURO VARCHAR2(60) NOT NULL,
NUMERO NUMBER NOT NULL,
COMPLEMENTO VARCHAR2(10),

CONSTRAINT PK_EVENTO PRIMARY KEY (NOME_DO_EVENTO,DATA_EVENTO)

);

CREATE TABLE ESPORTES_EVENTO(
ESPORTE VARCHAR2(15) NOT NULL,
NOME_DO_EVENTO VARCHAR2(20) NOT NULL,
DATA_EVENTO DATE NOT NULL,

CONSTRAINT PK_ESPORTES_EVENTO PRIMARY KEY (ESPORTE,NOME_DO_EVENTO,DATA_EVENTO),
CONSTRAINT FK_ESPORTES_EVENTO_EVENTO FOREIGN KEY (NOME_DO_EVENTO,DATA_EVENTO) REFERENCES EVENTO(NOME_DO_EVENTO,DATA_EVENTO) ON DELETE CASCADE

);

CREATE TABLE COMPETICAO(
NOME_DA_COMPETICAO VARCHAR2(15) NOT NULL,
DATA_DA_COMPETICAO DATE NOT NULL,
CLASSIFICACAO VARCHAR2(12) NOT NULL,
MODALIDADE VARCHAR2(12) NOT NULL,

CONSTRAINT PK_COMPETICAO PRIMARY KEY (NOME_DA_COMPETICAO,DATA_DA_COMPETICAO)
);

CREATE TABLE COMPETICAO_EM_EVENTO(
NOME_DA_COMPETICAO VARCHAR2(15) NOT NULL,
DATA_COMPETICAO DATE NOT NULL,
NOME_DO_EVENTO VARCHAR2(20) NOT NULL,
DATA_EVENTO DATE NOT NULL,

CONSTRAINT PK_COMPETICAO_EM_EVENTO PRIMARY KEY (NOME_DA_COMPETICAO,DATA_COMPETICAO),
CONSTRAINT FK_COMPETICAO_EM_EVENTO_COMPETICAO FOREIGN KEY (NOME_DA_COMPETICAO,DATA_COMPETICAO) REFERENCES COMPETICAO(NOME_DA_COMPETICAO,DATA_DA_COMPETICAO) ON DELETE CASCADE,
CONSTRAINT FK_COMPETICAO_EM_EVENTO_EVENTO FOREIGN KEY (NOME_DO_EVENTO,DATA_EVENTO) REFERENCES EVENTO(NOME_DO_EVENTO,DATA_EVENTO) ON DELETE CASCADE
);

CREATE TABLE PARTICIPA(
ATLETA CHAR(14) NOT NULL,
NOME_DA_COMPETICAO VARCHAR2(15) NOT NULL,
DATA_DA_COMPETICAO DATE NOT NULL,

CONSTRAINT PK_PARTICIPA PRIMARY KEY (ATLETA,NOME_DA_COMPETICAO,DATA_DA_COMPETICAO),
CONSTRAINT FK_PARTICIPA_ATLETA FOREIGN KEY (ATLETA) REFERENCES ATLETA(PESSOA) ON DELETE CASCADE,
CONSTRAINT FK_PARTICIPA_COMPETICAO FOREIGN KEY (NOME_DA_COMPETICAO,DATA_DA_COMPETICAO) REFERENCES COMPETICAO(NOME_DA_COMPETICAO,DATA_DA_COMPETICAO) ON DELETE CASCADE,
CONSTRAINT CK_PARTICIPA_ATLETA_CPF CHECK(REGEXP_LIKE(ATLETA, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}'))
);

CREATE TABLE RESULTADOS(
NOME_DA_COMPETICAO VARCHAR2(15) NOT NULL,
DATA_DA_COMPETICAO DATE NOT NULL,
ATLETA CHAR(14) NOT NULL,
RODADA NUMBER(2) NOT NULL,
PONTOS NUMBER,
RECORDE VARCHAR2(30),

CONSTRAINT PK_RESULTADOS PRIMARY KEY (NOME_DA_COMPETICAO,DATA_DA_COMPETICAO,ATLETA,RODADA),
CONSTRAINT FK_RESULTADOS_COMPETICAO FOREIGN KEY (NOME_DA_COMPETICAO, DATA_DA_COMPETICAO) REFERENCES COMPETICAO(NOME_DA_COMPETICAO,DATA_DA_COMPETICAO) ON DELETE CASCADE,
CONSTRAINT FK_RESULTADOS_ATLETA FOREIGN KEY (ATLETA) REFERENCES ATLETA(PESSOA) ON DELETE CASCADE,
CONSTRAINT CK_RESULTADOS_ATLETA_CPF CHECK(REGEXP_LIKE(ATLETA, '[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}'))
);

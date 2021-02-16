CREATE TABLE IF NOT EXISTS usuario (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    login VARCHAR(100) NOT NULL,
    senha VARCHAR(12) NOT NULL,
    data_nascimento DATE,
    sexo ENUM('MASCULINO', 'FEMININO') NOT NULL,
    data_criacao TIMESTAMP,
    CONSTRAINT uk_usuario_login
        UNIQUE KEY(login)
);

CREATE TABLE IF NOT EXISTS posicao (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(20) NOT NULL,
    CONSTRAINT uk_posicao_nome
        UNIQUE KEY(nome)
);

CREATE TABLE IF NOT EXISTS conta (
    id INTEGER PRIMARY KEY,
    biografia VARCHAR(500) NOT NULL,
    nick_name VARCHAR(16) NOT NULL,
    posicao_1 INTEGER,
    posicao_2 INTEGER,
    foto VARCHAR(100),
    data_criacao TIMESTAMP,
    CONSTRAINT fk_conta_id
        FOREIGN KEY(id)
        REFERENCES usuario(id),
    CONSTRAINT fk_conta_posicao_1
        FOREIGN KEY(posicao_1)
        REFERENCES posicao(id),
    CONSTRAINT fk_conta_posicao_2
        FOREIGN KEY(posicao_2)
        REFERENCES posicao(id)
);

CREATE TABLE IF NOT EXISTS curtida (
  id_conta INTEGER,
  id_conta_curtida INTEGER,
  data_curtida TIMESTAMP NOT NULL,
  CONSTRAINT pk_curtida
    PRIMARY KEY(id_conta, id_conta_curtida),
  CONSTRAINT fk_curtida
    FOREIGN KEY(id_conta)
    REFERENCES conta(id),
  CONSTRAINT fk_conta_curtida
    FOREIGN KEY(id_conta_curtida)
    REFERENCES conta(id)
);

CREATE TABLE IF NOT EXISTS combinacao (
  id_combinacao_conta_1 INTEGER,
  id_combinacao_conta_2 INTEGER,
  data_combinacao TIMESTAMP NOT NULL,
  CONSTRAINT pk_match
    PRIMARY KEY( id_combinacao_conta_1,  id_combinacao_conta_2),
  CONSTRAINT fk_match_1
    FOREIGN KEY( id_combinacao_conta_1)
    REFERENCES conta(id),
  CONSTRAINT fk_match_2  
    FOREIGN KEY( id_combinacao_conta_2)
    REFERENCES conta(id)     
);

CREATE TABLE IF NOT EXISTS avaliacao (
  id_conta_avaliador INTEGER,
  id_conta_avaliada INTEGER,
  data_avaliacao TIMESTAMP NOT NULL,
  nota_avaliacao ENUM('1', '2', '3', '4', '5') NOT NULL,
  comentario_avaliacao VARCHAR(500),
  CONSTRAINT pk_avaliacao
    PRIMARY KEY( id_conta_avaliador, id_conta_avaliada),
  CONSTRAINT fk_conta_avaliador
    FOREIGN KEY(id_conta_avaliador)
    REFERENCES conta(id),
  CONSTRAINT fk_conta_avaliada  
    FOREIGN KEY(id_conta_avaliada)
    REFERENCES conta(id)     
);

CREATE TABLE IF NOT EXISTS chat (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  id_conta_de INTEGER NOT NULL,
  id_conta_para INTEGER NOT NULL,
  data_mensagem TIMESTAMP NOT NULL,
  mensagem VARCHAR(500) NOT NULL,
  CONSTRAINT fk_id_conta_de
    FOREIGN KEY(id_conta_de)
    REFERENCES conta(id),
  CONSTRAINT fk_id_conta_para  
    FOREIGN KEY(id_conta_para)
    REFERENCES conta(id)     
);

INSERT INTO usuario (login, senha, data_nascimento, sexo, data_criacao)
VALUES ('rachelnmlbarros@fac.pe.senac.br', '20200201', '1989-06-25', 'FEMININO', CURRENT_TIMESTAMP());
INSERT INTO usuario (login, senha, data_nascimento, sexo, data_criacao)
VALUES ('luizcarlos@fac.pe.senac.br', '20200202', '1999-10-20', 'MASCULINO', CURRENT_TIMESTAMP());
INSERT INTO usuario (login, senha, data_nascimento, sexo, data_criacao)
VALUES ('guilhermemagno@fac.pe.senac.br', '20200203', '1991-07-05', 'MASCULINO', CURRENT_TIMESTAMP());
INSERT INTO usuario (login, senha, data_nascimento, sexo, data_criacao)
VALUES ('julianadornelas@fac.pe.senac.br', '20200204', '1995-03-27', 'FEMININO', CURRENT_TIMESTAMP());
INSERT INTO usuario (login, senha, data_nascimento, sexo, data_criacao)
VALUES ('pedro@fac.pe.senac.br', '20200205', '1985-04-02', 'MASCULINO', CURRENT_TIMESTAMP());

INSERT INTO posicao (nome)
VALUES ('Suporte');
INSERT INTO posicao (nome)
VALUES ('Selva');
INSERT INTO posicao (nome)
VALUES ('Atirador');
INSERT INTO posicao (nome)
VALUES ('Topo');
INSERT INTO posicao (nome)
VALUES ('Meio');

INSERT INTO conta (id,biografia, nick_name, posicao_1, posicao_2, foto, data_criacao)
VALUES 
  ('1','Suporte, não babá!', 'DnaClotilde', '1', NULL, 'fotos/77y3572t5hbvfjha.png', CURRENT_TIMESTAMP()),
  ('2', 'Mano, so quero jogar, nem ranked faço questão, é isso, obg', 'The ashens lord', '5', '3', 'fotos/77y3572t5hbvfjha.png', CURRENT_TIMESTAMP()),
  ('3', 'Gosto de jogar de adc! Procuro (preferencialmente) suporte ou jungles para fazer duos... Só aceito ouro IV pra cima! Dispenso noobs e trolls! Dou 5 estrelas se for sincero e jogar sério.','Magno19', '3', '5', 'fotos/77y3572t5hbvfjha.png', CURRENT_TIMESTAMP()),
  ('4', 'Se não for jogar sério, desliza, paspalho.', 'Cassambadelixo', '5', NULL, 'fotos/77y3572t5hbvfjha.png', CURRENT_TIMESTAMP()),
  ('5', 'Joguei LoL de forma competitiva durante os anos de 2012 e 2014, parando totalmente de jogar no começo de 2015 . O meu maior Elo na época era Ouro IV ou III (não lembro mais).
Hoje voltei ao jogo apenas para me divertir e não penso em jogar partidas ranqueadas mais, até pq não conheço mais os heróis e não tenho tanto tempo para me dedicar ao jogo.
De toda a forma, gosto de jogar para brincar e dar algumas risadas.', 'Rarock Blade', '4', '1','fotos/77y3572t5hbvfjha.png', CURRENT_TIMESTAMP());


INSERT INTO curtida (id_conta, id_conta_curtida, data_curtida)
VALUES
  ('1','2',CURRENT_TIMESTAMP()), 
  ('1','3',CURRENT_TIMESTAMP()),
  ('1','4',CURRENT_TIMESTAMP()),
  ('1','5',CURRENT_TIMESTAMP()); 

INSERT INTO combinacao (id_combinacao_conta_1, id_combinacao_conta_2, data_combinacao)
VALUES
  ('1','2',CURRENT_TIMESTAMP()), 
  ('1','3',CURRENT_TIMESTAMP()),
  ('1','4',CURRENT_TIMESTAMP()),
  ('1','5',CURRENT_TIMESTAMP());

INSERT INTO chat (id_conta_de, id_conta_para , data_mensagem, mensagem) 
VALUES
  ('4','1', CURRENT_TIMESTAMP(), 'Add lá'),
  ('1','4', CURRENT_TIMESTAMP(), 'Blz flw'),
  ('4','1', CURRENT_TIMESTAMP(), 'GG sup lixo'),
  ('3','1', CURRENT_TIMESTAMP(), 'O pai ta on');

INSERT INTO avaliacao (id_conta_avaliador, id_conta_avaliada, data_avaliacao, nota_avaliacao, comentario_avaliacao)
VALUES
  ('4', '1', CURRENT_TIMESTAMP(), '1', NULL),
  ('3', '1', CURRENT_TIMESTAMP(), '5', 'Gostei de jogar com ela!');

UPDATE usuario SET login = 'luizccmjunior@fac.pe.senac.br'
WHERE id = '2';

SELECT mensagem FROM chat WHERE id = 2;

SELECT * FROM conta;

SELECT comentario_avaliacao FROM avaliacao WHERE (nota_avaliacao > 3);

DELETE FROM chat WHERE id = 1;


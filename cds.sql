CREATE DATABASE db_cds;

USE db_cds;

CREATE TABLE Tb_Artista (
    Cod_Art INT NOT NULL PRIMARY KEY,
    Nome_Art VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE Tb_Gravadora (
    Cod_Grav INT NOT NULL PRIMARY KEY,
    Nome_Grav VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Tb_Categoria (
    Cod_Cat INT NOT NULL PRIMARY KEY,
    Nome_Cat VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Tb_Estado (
    Sigla_Est CHAR(2) NOT NULL PRIMARY KEY,
    Nome_Est CHAR(50) NOT NULL UNIQUE
);

CREATE TABLE Tb_Cidade (
    Cod_Cid INT NOT NULL PRIMARY KEY,
    Sigla_Est CHAR(2) NOT NULL,
    Nome_Cid VARCHAR(100) NOT NULL,

    FOREIGN KEY (Sigla_Est) REFERENCES Tb_Estado(Sigla_Est)
);

CREATE TABLE Tb_Cliente (
    Cod_Cli INT NOT NULL PRIMARY KEY,
    Cod_Cid INT NOT NULL,
    Nome_Cli VARCHAR(100) NOT NULL,
    End_Cli VARCHAR(200) NOT NULL,
    Renda_Cli DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (Renda_Cli >= 0),
    Sexo_Cli ENUM('F','M') NOT NULL DEFAULT 'F',

    FOREIGN KEY (Cod_Cid) REFERENCES Tb_Cidade(Cod_Cid)
);

CREATE TABLE Tb_Conjuge (
    Cod_Cli INT NOT NULL PRIMARY KEY,
    Nome_Conj VARCHAR(100) NOT NULL,
    Renda_Conj DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (Renda_Conj >= 0),
    Sexo_Conj ENUM('F','M') NOT NULL DEFAULT 'M',

    FOREIGN KEY (Cod_Cli) REFERENCES Tb_Cliente(Cod_Cli)
);

CREATE TABLE Tb_Funcionario (
    Cod_Func INT NOT NULL PRIMARY KEY,
    Nome_Func VARCHAR(100) NOT NULL,
    End_Func VARCHAR(200) NOT NULL,
    Sal_Func DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (Sal_Func >= 0),
    Sexo_Func ENUM('F','M') NOT NULL DEFAULT 'M'
);

CREATE TABLE Tb_Dependente (
    Cod_Dep INT NOT NULL PRIMARY KEY,
    Cod_Func INT NOT NULL,
    Nome_Dep VARCHAR(100) NOT NULL,
    Sexo_Dep ENUM('F','M') NOT NULL DEFAULT 'M',

    FOREIGN KEY (Cod_Func) REFERENCES Tb_Funcionario(Cod_Func)
);

CREATE TABLE Tb_Titulo (
    Cod_Tit INT NOT NULL PRIMARY KEY,
    Cod_Cat INT NOT NULL,
    Cod_Grav INT NOT NULL,
    Nome_CD VARCHAR(100) NOT NULL UNIQUE,
    Val_CD DECIMAL(10,2) NOT NULL CHECK (Val_CD > 0),
    Qtd_Estq INT NOT NULL CHECK (Qtd_Estq >= 0),

    FOREIGN KEY (Cod_Cat) REFERENCES Tb_Categoria(Cod_Cat),
    FOREIGN KEY (Cod_Grav) REFERENCES Tb_Gravadora(Cod_Grav)
);

CREATE TABLE Tb_Pedido (
    Num_Ped INT NOT NULL PRIMARY KEY,
    Cod_Cli INT NOT NULL,
    Cod_Func INT NOT NULL,
    Data_Ped DATETIME NOT NULL,
    Val_Ped DECIMAL(10,2) NOT NULL DEFAULT 0 CHECK (Val_Ped >= 0),

    FOREIGN KEY (Cod_Cli) REFERENCES Tb_Cliente(Cod_Cli),
    FOREIGN KEY (Cod_Func) REFERENCES Tb_Funcionario(Cod_Func)
);

CREATE TABLE Tb_Titulo_Pedido (
    Num_Ped INT NOT NULL,
    Cod_Tit INT NOT NULL,
    Qtd_CD INT NOT NULL CHECK (Qtd_CD >= 1),
    Val_CD DECIMAL(10,2) NOT NULL CHECK (Val_CD > 0),

    PRIMARY KEY (Num_Ped, Cod_Tit),

    FOREIGN KEY (Num_Ped) REFERENCES Tb_Pedido(Num_Ped),
    FOREIGN KEY (Cod_Tit) REFERENCES Tb_Titulo(Cod_Tit)
);

CREATE TABLE Tb_Titulo_Artista (
    Cod_Tit INT NOT NULL,
    Cod_Art INT NOT NULL,

    PRIMARY KEY (Cod_Tit, Cod_Art),

    FOREIGN KEY (Cod_Tit) REFERENCES Tb_Titulo(Cod_Tit),
    FOREIGN KEY (Cod_Art) REFERENCES Tb_Artista(Cod_Art)
);

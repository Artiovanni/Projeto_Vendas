-- Criação do banco de dados
CREATE DATABASE ProjetoVendas;
USE ProjetoVendas;

-- Tabela: Categorias
CREATE TABLE Categorias (
    Categoria_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Categoria VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela: Cidades
CREATE TABLE Cidades (
    Cidade_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Cidade VARCHAR(100) NOT NULL,
    Estado VARCHAR(50) NOT NULL,
    CONSTRAINT estado_valido CHECK (LENGTH(Estado) = 2) -- Ex: SP, RJ
);

-- Tabela: Clientes
CREATE TABLE Clientes (
    Cliente_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Genero VARCHAR(10) NOT NULL,
    Data_Nascimento DATE NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Cidade_ID INT NOT NULL,
    CONSTRAINT chk_genero CHECK (Genero IN ('Masculino', 'Feminino', 'Outro')),
    FOREIGN KEY (Cidade_ID) REFERENCES Cidades(Cidade_ID)
);

-- Tabela: Produtos
CREATE TABLE Produtos (
    Produto_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Produto VARCHAR(100) NOT NULL,
    Preco DECIMAL(10,2) NOT NULL CHECK (Preco >= 0),
    Categoria_ID INT NOT NULL,
    FOREIGN KEY (Categoria_ID) REFERENCES Categorias(Categoria_ID)
);

-- Tabela: Vendedores
CREATE TABLE Vendedores (
    Vendedor_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Vendedor VARCHAR(100) NOT NULL,
    Genero VARCHAR(10) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela: Vendas
CREATE TABLE Vendas (
    Venda_ID INT AUTO_INCREMENT PRIMARY KEY,
    Produto_ID INT NOT NULL,
    Cliente_ID INT NOT NULL,
    Vendedor_ID INT NOT NULL,
    Quantidade INT NOT NULL CHECK (Quantidade > 0),
    Data_Venda DATE NOT NULL,
    Valor_Unitario DECIMAL(10,2) NOT NULL CHECK (Valor_Unitario >= 0),
    Valor_Total DECIMAL(10,2) NOT NULL CHECK (Valor_Total >= 0),
    FOREIGN KEY (Produto_ID) REFERENCES Produtos(Produto_ID),
    FOREIGN KEY (Cliente_ID) REFERENCES Clientes(Cliente_ID),
    FOREIGN KEY (Vendedor_ID) REFERENCES Vendedores(Vendedor_ID)
);

-- Tabela: Transportadoras
CREATE TABLE Transportadoras (
    Transportadora_ID INT AUTO_INCREMENT PRIMARY KEY,
    Nome_Transportadora VARCHAR(100) NOT NULL UNIQUE
);

-- Tabela: Entregas
CREATE TABLE Entregas (
    Entrega_ID INT AUTO_INCREMENT PRIMARY KEY,
    Data_Venda DATE NOT NULL,
    Data_Entrega DATE NOT NULL,
    Venda_ID INT NOT NULL,
    Transportadora_ID INT NOT NULL,
    Status_Entrega VARCHAR(20) NOT NULL,
    CONSTRAINT chk_status_entrega CHECK (Status_Entrega IN ('Pendente', 'Em transporte', 'Entregue', 'Cancelada')),
    FOREIGN KEY (Venda_ID) REFERENCES Vendas(Venda_ID),
    FOREIGN KEY (Transportadora_ID) REFERENCES Transportadoras(Transportadora_ID),
    CONSTRAINT chk_data_entrega CHECK (Data_Entrega >= Data_Venda)
);

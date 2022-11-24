CREATE TABLE Fornecedor (CodForn int NOT NULL UNIQUE,
    Nome varchar(40) NOT NULL,
    CNPJ numeric(14) NOT NULL UNIQUE,
    TipoProduto varchar(20) NOT NULL check(TipoProduto in ('medicamentos', 'casinha', 'racao', 'roupa', 'outros')),
    Endereco varchar(100),
    Email varchar(40),
    Telefone numeric(12) NOT NULL,
    PRIMARY KEY (CodForn));

CREATE TABLE ComprasFornecedor(NroPedidoForn int NOT NULL,
    CodForn int NOT NULL,
    CodProd int NOT NULL,
    Quantidade int NOT NULL check(Quantidade > 0),
    Custo numeric(6,2) NOT NULL check(Custo > 0),
    PRIMARY KEY (NroPedidoForn, CodForn, CodProd),
    FOREIGN KEY (CodForn) REFERENCES Fornecedor,
    FOREIGN KEY (CodProd) REFERENCES Produtos);

CREATE TABLE Produtos (CodProd int NOT NULL UNIQUE,
    Nome varchar(40) NOT NULL,
    Preco numeric(6,2) NOT NULL, check(Preco > 0)
    Quantidade int check(Quantidade > 0),
    PRIMARY KEY (CodProd));

CREATE TABLE Compras (NroPedido int NOT NULL,
    CodProd int NOT NULL,
    CodCliente int NOT NULL,
    QtdProduto int NOT NULL check(QtdProduto > 0),
    DataCompra date,
    PRIMARY KEY (NroPedido, CodProd, CodCliente),
    FOREIGN KEY (CodCliente) REFERENCES Cliente,
    FOREIGN KEY (CodProd) REFERENCES Produtos);

CREATE TABLE Cliente (CodCliente int NOT NULL UNIQUE,
    Nome varchar(40) NOT NULL,
    CPF numeric(11) NOT NULL UNIQUE,
    Email varchar(40),
    Endereco varchar(100),
    Telefone numeric(12) NOT NULL,
    DataNascimento date,
    VencimentoPlano date,
    CodPlano int,
    PRIMARY KEY (CodCliente),
    FOREIGN KEY (CodPlano) REFERENCES Planos);

CREATE TABLE Pet (CodPet int NOT NULL UNIQUE,
    Nome varchar(20) NOT NULL,
    CodCliente int NOT NULL,
    CodR int NOT NULL,
    Peso int check(Peso > 0),
    Idade int check(idade > 0),
    PRIMARY KEY (CodPet),
    FOREIGN KEY (CodCliente) REFERENCES Cliente,
    FOREIGN KEY (CodR) REFERENCES Raca);

CREATE TABLE ProblemaSaude (CodPet int NOT NULL,
    Problema varchar(20) NOT NULL,
    PRIMARY KEY (CodPet, Problema),
    FOREIGN KEY (CodPet) REFERENCES Pet);

CREATE TABLE Raca (CodR int NOT NULL UNIQUE,
    TipoAnimal varchar(20) NOT NULL,
    Raca varchar(30) NOT NULL,
    ExpectativaVida int NOT NULL check(ExpectativaVida > 0),
    PRIMARY KEY (CodR));

CREATE TABLE Consulta (CodPet int NOT NULL,
    CRMV numeric(5) NOT NULL,
    Data date NOT NULL,
    Hora time NOT NULL,
    CodPlano int,
    Preco numeric(6,2) NOT NULL check(Preco > 0),
    LevarOuBuscar varchar(15) check(LevarOuBuscar in ('Levar', 'Buscar', 'Levar e Buscar')),
    PRIMARY KEY (CodPet, CRMV, Data, Hora),
    FOREIGN KEY (CodPet) REFERENCES Pet,
    FOREIGN KEY (CRMV) REFERENCES Funcionarios,
    FOREIGN KEY (CodPlano) REFERENCES Planos);

CREATE TABLE Racao (CodProd int NOT NULL,
IdadeRecomendada int NOT NULL check( IdadeRecomendada > 0),
PRIMARY KEY (CodProd),
FOREIGN KEY (CodProd) REFERENCES Produtos);

CREATE TABLE RacaoIndicada (CodProd int NOT NULL,
    CodR int NOT NULL,
    PRIMARY KEY (CodProd, CodR),
    FOREIGN KEY (CodProd) REFERENCES Produtos,
    FOREIGN KEY (CodR) REFERENCES Raca)
    CREATE TABLE Medicamentos (CodProd int NOT NULL,
    Porte varchar(10) NOT NULL check(Porte in ('pequeno', 'medio', 'grande')),
    ViaAplicacao varchar(20) NOT NULL,
    PRIMARY KEY (CodProd),
    FOREIGN KEY (CodProd) REFERENCES Produtos);

CREATE TABLE Indicacoes (CodProd int NOT NULL,
    Indicacao varchar(25) NOT NULL,
    PRIMARY KEY (CodProd, Indicacao),
    FOREIGN KEY (CodProd) REFERENCES Produtos);

CREATE TABLE Casinha (CodProd int NOT NULL,
    Cor varchar(20) NOT NULL,
    Formato varchar(20) NOT NULL,
    Porte varchar(20) NOT NULL check(Porte in ('pequeno', 'medio', 'grande')),
    PRIMARY KEY (CodProd),
    FOREIGN KEY (CodProd) REFERENCES Produtos);

CREATE TABLE Roupa (CodProd int NOT NULL,
    Cor varchar(20) NOT NULL,
    Tamanho varchar(2) NOT NULL check(Tamanho in ('PP', 'P', 'M', 'G',
    'GG', 'U')),
    Tipo varchar(20) NOT NULL check(Tipo in ('sapato', 'coleira', 'agasalho',
    'gravata', 'laco', 'chapeu', 'outras')),
    PRIMARY KEY (CodProd),
    FOREIGN KEY (CodProd) REFERENCES Produtos);

CREATE TABLE BanhoTosa (CodPet int NOT NULL,
    CodF int NOT NULL,
    CodPlano int,
    Data date NOT NULL,
    Hora time NOT NULL,
    Tipo varchar(40) NOT NULL check(Tipo in ('Banho', 'Tosa', 'Banho e Tosa')),
    Preco numeric(6,2) NOT NULL check(Preco > 0),
    LevarOuBuscar varchar(15) check(LevarOuBuscar in ('Levar', 'Buscar', 'Levar e Buscar')),
    PRIMARY KEY (CodPet, CodF, Data, Hora),
    FOREIGN KEY (CodPet) REFERENCES Pet,
    FOREIGN KEY (CodF) REFERENCES Funcionarios
    FOREIGN KEY (CodPlano) REFERENCES Planos);

CREATE TABLE Funcionarios (CodF int NOT NULL UNIQUE,
    Nome varchar(40) NOT NULL,
    CPF numeric(11) NOT NULL UNIQUE,
    Email varchar(40),
    Endereco varchar(100), NOT NULL
    Telefone numeric(12), NOT NULL
    DataNascimento date,
    Cargo varchar(20) NOT NULL,
    Salario numeric(7,2) NOT NULL check(Salario > 0),
    CRMV numeric(5) UNIQUE,
    PRIMARY KEY (CodF));

CREATE TABLE Planos (CodPlano int NOT NULL UNIQUE,
    Descricao varchar(25) NOT NULL check(Descricao in ('Basico 1 pet', 'Basico 2 pets', 'Basico 3 ou mais pets', 'Medio 1 pet', 'Medio 2 pets', 'Medio 3 ou
    mais pets', 'Premium 1 pet', 'Premium 2 pets', 'Premium 3 ou mais pets')),
    Preco numeric(6,2) check(Preco > 0),
    PRIMARY KEY (CodPlano));
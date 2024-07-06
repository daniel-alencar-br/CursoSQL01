
-- Criar banco de dados

-- Nome/apelido do arquivo, caminho fisico, 
-- Tamanho inicial, tamanho m�ximo

Create Database Curso On Primary     -- nome do bd / filegroup
 (Name = 'Dados1', Filename = 'c:\bdsql\dados.mdf', 
  Size = 50, MaxSize = 100)
Log On
 (Name = 'Log1', Filename = 'c:\bdsql\log.ldf', 
  Size = 10, MaxSize = 50)

-- Acesso ao BD

Use Curso

Create Table Alunos (Cod int)   -- Cria��o de BD

-- Cen�rio : 5 Teras (500 GB de RH / 4.5 TB Financeiro)

-- Cria��o de novo Filegroup

Alter Database Curso Add Filegroup RH

sp_helpfilegroup   -- ver os filegroups

-- Novo Arquivo no 2� Filegroup

Alter Database Curso Add File
   (Name = 'DadosRH', Filename = 'c:\bdsql\dadosrh.ndf', 
    Size = 40, MaxSize = 80) To Filegroup RH

-- Cria��o de Tabela no Filegroup

Create Table Funcionarios (Cod int) On RH

-- Particionamento de tabela
-- Fun��o - L�gica / Esquema - Mapeamento

set dateformat dmy

Create Partition Function Vendas (Date)
  As Range Left For Values ('31/12/2020')  -- at� 31/12/2020
										   -- ap�s 31/12/2020
Go

Create Partition Scheme Mapa 
  As Partition Vendas To (RH, [Primary])
Go

Create Table BIVendas (DtVenda Date Primary Key, Qtd Int)
  On Mapa (DtVenda)
Go

-- Visualiza��o de informa��es de tabela de sistema

select * from sys.sysindexes
  where id = OBJECT_ID('BIVendas')

select * from sys.objects
  where type = 'U'

sp_help BIVendas

-- Ver aloca��o

Create Table abc (cod int, nome char(5000)) on rh

declare @ict int
set @ict = 1
while @ict < 5000
begin
 insert into abc (cod, nome) values (@ict, 'a')
  set @ict = @ict + 1
end

-- Metadados (informa��es de sistema)

sp_help   --- procedure de sistema

select * from sys.objects where type = 'U'  -- tabela de sistema

select db_name(), SUSER_NAME(), 
       GETDATE(), HOST_NAME()    -- fun��es de sistema

select @@SPID   -- variavel de sistema
sp_who          -- ver processos internos do SQL
kill 46         -- derruba processo

-- BD master

use Master

select * from sys.syslogins  -- usu�rios que acessam
select * from sys.sysdatabases  -- bancos existentes


-- Tabela para teste de Trigger

Create Table dbo.Alunos01 (Cod int, nota int)

Insert into Alunos01 (cod, nota) values (1, 7)
Insert into Alunos01 (cod, nota) values (2, 7)
Insert into Alunos01 (cod, nota) values (3, 7)

-- Trigger de Update

Go

Create Trigger altAluno01 On Alunos01 For Update As
Begin
  Declare @iAntiga Int, @iNova Int
  Set @iAntiga = (Select Nota From deleted)
  Set @iNova = (Select Nota From inserted)

  Print 'O Aluno teve a nota alterada de ' + Convert(varchar(5), @iAntiga) +
        ' para ' + Convert(varchar(5), @iNova)
End

Update Alunos01 Set Nota = 9 Where Cod = 2
Select * From Alunos01

Go

-- Trigger de Delete

Go

Create Trigger delAlunos01 On Alunos01 For Delete As
Begin
	Declare @iQtd Int
	Set @iQtd = (Select Count(*) From deleted)
	if @iQtd > 1
	begin
	  Print 'Não pode apagar mais de uma linha'
	  Rollback
	end
End

Delete From Alunos01
Select * From Alunos01
Delete From Alunos01 Where Cod = 2

-- Join

Select Top 1 * From TB_CLIENTE
Select Top 1 * From TB_PEDIDO
Select Top 1 * From TB_ITENSPEDIDO
Select Top 1 * From TB_PRODUTO

Select Top 1 ID_CLIENTE, Nome, E_MAIL From TB_CLIENTE
Select Top 1 ID_PEDIDO, ID_CLIENTE From TB_PEDIDO
Select Top 1 ID_PEDIDO, ID_PRODUTO, QUANTIDADE From TB_ITENSPEDIDO
Select Top 1 ID_PRODUTO, DESCRICAO From TB_PRODUTO

Select Top 1 C.ID_CLIENTE, C.Nome, C.E_MAIL From TB_CLIENTE C
Select Top 1 P.ID_PEDIDO, P.ID_CLIENTE From TB_PEDIDO P
Select Top 1 I.ID_PEDIDO, I.ID_PRODUTO, I.QUANTIDADE From TB_ITENSPEDIDO I
Select Top 1 PR.ID_PRODUTO, PR.DESCRICAO From TB_PRODUTO PR

Select C.ID_CLIENTE, C.Nome, C.E_MAIL, P.ID_PEDIDO, P.ID_CLIENTE  
  From TB_CLIENTE C, TB_PEDIDO P  -- Não executar

Select C.ID_CLIENTE, C.Nome, C.E_MAIL, P.ID_PEDIDO, P.ID_CLIENTE  
  From TB_CLIENTE C Inner Join TB_PEDIDO P On C.ID_CLIENTE = P.ID_CLIENTE

Select C.ID_CLIENTE, C.Nome, C.E_MAIL, P.ID_PEDIDO, P.ID_CLIENTE,
       I.ID_PEDIDO, I.ID_PRODUTO
  From TB_CLIENTE C Inner Join TB_PEDIDO P On C.ID_CLIENTE = P.ID_CLIENTE
       ,TB_ITENSPEDIDO I   -- não executar

Select C.ID_CLIENTE, C.Nome, C.E_MAIL, P.ID_PEDIDO, P.ID_CLIENTE,
       I.ID_PEDIDO, I.ID_PRODUTO
  From TB_CLIENTE C Inner Join TB_PEDIDO P On C.ID_CLIENTE = P.ID_CLIENTE
                    Inner Join TB_ITENSPEDIDO I On I.ID_PEDIDO = P.ID_PEDIDO   

Select C.ID_CLIENTE, C.Nome, C.E_MAIL, P.ID_PEDIDO, P.ID_CLIENTE,
       I.ID_PEDIDO, I.ID_PRODUTO, PR.ID_PRODUTO, PR.DESCRICAO
  From TB_CLIENTE C Inner Join TB_PEDIDO P On C.ID_CLIENTE = P.ID_CLIENTE
                    Inner Join TB_ITENSPEDIDO I On I.ID_PEDIDO = P.ID_PEDIDO   
					,TB_PRODUTO PR  -- não executar

Select C.ID_CLIENTE, C.Nome, C.E_MAIL, P.ID_PEDIDO, P.ID_CLIENTE,
       I.ID_PEDIDO, I.ID_PRODUTO, PR.ID_PRODUTO, PR.DESCRICAO
  From TB_CLIENTE C Inner Join TB_PEDIDO P On C.ID_CLIENTE = P.ID_CLIENTE
                    Inner Join TB_ITENSPEDIDO I On I.ID_PEDIDO = P.ID_PEDIDO   
					Inner Join TB_PRODUTO PR On PR.ID_PRODUTO = I.ID_PRODUTO
					
Select C.ID_CLIENTE, C.Nome, C.E_MAIL, PR.DESCRICAO
  From TB_CLIENTE C Inner Join TB_PEDIDO P On C.ID_CLIENTE = P.ID_CLIENTE
                    Inner Join TB_ITENSPEDIDO I On I.ID_PEDIDO = P.ID_PEDIDO   
					Inner Join TB_PRODUTO PR On PR.ID_PRODUTO = I.ID_PRODUTO
     Where PR.DESCRICAO = 'ABRIDOR SACA & ROLHA'

-- Left / Right Join

Select Top 1 * From TB_EMPREGADO	-- Estrutura
Select Top 1 * From TB_CARGO

Select Top 1 Nome, ID_CARGO From TB_EMPREGADO  -- campos
Select Top 1 ID_CARGO, Cargo From TB_CARGO

Select Top 1 E.Nome, E.ID_CARGO From TB_EMPREGADO E  -- apelido
Select Top 1 C.ID_CARGO, C.Cargo From TB_CARGO C

Select E.Nome, E.ID_CARGO, C.ID_CARGO, C.Cargo   -- vinculo
  From TB_EMPREGADO E, TB_CARGO C

Select E.Nome, E.ID_CARGO, C.ID_CARGO, C.Cargo   -- join
  From TB_EMPREGADO E Inner Join TB_CARGO C On E.ID_CARGO = C.ID_CARGO

Select E.Nome, C.Cargo   -- formatação
  From TB_EMPREGADO E Inner Join TB_CARGO C On E.ID_CARGO = C.ID_CARGO

Select E.Nome, C.Cargo   
  From TB_EMPREGADO E Join TB_CARGO C On E.ID_CARGO = C.ID_CARGO  -- 61 linhas

Select E.Nome, C.Cargo   
  From TB_EMPREGADO E Left Join TB_CARGO C On E.ID_CARGO = C.ID_CARGO -- 71 linhas

Select E.Nome, C.Cargo   
  From TB_EMPREGADO E Right Join TB_CARGO C On E.ID_CARGO = C.ID_CARGO -- 69 linhas

Select E.Nome, C.Cargo   
  From TB_EMPREGADO E Full Join TB_CARGO C On E.ID_CARGO = C.ID_CARGO  -- 79 linhas

-- Null

Select *
  From TB_EMPREGADO
    Where SINDICALIZADO Is Null   -- pegar campos nulos

Select Nome, IsNull(SINDICALIZADO, '?') As Sindicato
  From TB_EMPREGADO

Select Nome, Iif(SINDICALIZADO = 'S', 'Sim', 'Não') As Sindicato
  From TB_EMPREGADO











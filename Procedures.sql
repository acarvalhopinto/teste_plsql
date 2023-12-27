CREATE PROCEDURE gravar_pedido(pedidoId  NUMBER,
                               clienteId NUMBER,
                               produtoId NUMBER,
                               qde       NUMBER) AS

  n_pedido           number;
  n_iten             number;
  cliente_encontrado number;
  produto_encontrado number;
BEGIN
  -- Valida existencia de cliente
  Select COUNT(cliente_id)
    INTO cliente_encontrado
    FROM clientes
   WHERE cliente_id = clienteId;

  IF (cliente_encontrado == 0) THEN
    RAISE eClienteNaoEncontrado;
  END IF;

  -- Valida existencia do produto
  Select COUNT(produto_id)
    INTO produto_encontrado
    FROM produtos
   WHERE produto_id = produtoId;

  IF (produto_encontrado == 0) THEN
    RAISE eProdutoNaoEncontrado;
  END IF;

  -- Verifica se o pedido já existe 
  n_pedido := pedidoId;
  if pedidoId == null || pedidoId == 0 then
    -- Caso não existe ele cria um novo pedido.
    n_pedido := criar_pedido(clienteId, produtoId);
  end if;

  -- Recupera o sequencial para a chave primaria da tabela itens_pedido
  SELECT itens_pedido_seq.nextval AS n_iten FROM DUAL;

  -- Inseri o Item no pedido
  Insert into itens_pedido
    (item_id, pedido_id, produto_id, quantidade)
  values
    (n_iten, n_pedido, produtoId, qde);

  COMMIT;
EXCEPTION
  WHEN eClienteNaoEncontrado THEN
    RAISE_APPLICATION_ERROR(-20001, 'Cliente nao encontrado.');
    ROLLBACK;
  
  WHEN eProdutoNaoEncontrado THEN
    RAISE_APPLICATION_ERROR(-20002, 'Produto nao encontrado.');
    ROLLBACK;
  
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Falha ao inserir pedido/item_pedido.');
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    DBMS_OUTPUT.PUT_LINE(SQLCODE);
    ROLLBACK;
 
END;

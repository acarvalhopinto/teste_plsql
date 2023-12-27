CREATE TRIGGER calcular_total_pedido
  AFTER INSERT ON itens_pedido
DECLARE
  v_item number;
BEGIN
  -- Atualiza a coluna total_pedido com o valor do novo item.
  Update pedidos
     set total_pedido = nvl(total_pedido, 0) +
                        ( recuperar_valor_produto(new.produto_id) * new.quantidade)
   Where pedido_id = new.pedido_id;
END;

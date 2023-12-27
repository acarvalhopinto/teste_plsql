create function recuperar_total_pedido(pedidoId in NUMBER) return NUMBER is
  t_pedido NUMBER;
begin
  -- Consulta e retorna o valor atual do pedido
  Select total_pedido
    into t_pedido
    from pedidos ip
   Where ip.pedido_id = pedidoId;

  return t_pedido;

end calcular_total_pedido;

/

create function recuperar_total_pedido_por_itens(pedidoId in NUMBER)
  return NUMBER is
  t_pedido NUMBER;
begin
  -- Consulta e retorna o valor atual do pedido por itens.
  Select Sum(p.valor * ip.quantidade)
    into t_pedido
    from itens_pedido ip
    join produtos p
      on p.produto_id = ip.produto_id
   Where ip.pedido_id = pedidoId;

  return t_pedido;

end recuperar_total_pedido_por_itens;
/


create function recuperar_valor_produto(produtoId in NUMBER) return NUMBER is
  t_valor NUMBER;
begin
  -- Consulta e retorna o valor atual do pedido por itens.
  Select p.valor
    into t_valor
    from produtos p
   Where p.produto_id = produtoId;

  return t_valor;

end recuperar_valor_produto;

/

create function criar_pedido(clienteId in NUMBER, totalPedido in NUMBER)
  return NUMBER is
  n_pedido NUMBER;
begin
  -- Function para criar um novo pedido e devolver o id gerado.

  SELECT pedidos_seq.nextval AS n_pedido FROM DUAL;

  Insert into pedido
    (pedido_id, cliente_id, data_pedido, total_pedido)
  values
    (n_pedido, clienteId, sysdate, totalPedido);

  return n_pedido;

end criar_pedido;

/

create function recuperar_total_pedido_por_itens(pedidoId in NUMBER) return NUMBER is
t_pedido NUMBER;
begin
  -- Consulta e retorna o valor atual do pedido por itens.
Select Sum(p.valor * ip.quantidade) into t_pedido from itens_pedido ip join produtos p on p.produto_id = ip.produto_id Where ip.pedido_id = pedidoId;

return t_pedido;

end recuperar_total_pedido_por_itens;
/

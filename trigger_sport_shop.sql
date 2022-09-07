create trigger trg_sales_insert
    after insert on tab_sales
    for each row
    insert into tab_history_sales(event_type_long_id, massage)
    value ((select event_type_log_id
            from tab_event_types
            where event_type_name='insert'),
            concat
                ((select first_name
                 from tab_human_name
                 where tab_human_name.id_human_name=
                       (select id_client_name
                        from tab_clients
                        where tab_clients.id_client = new.id_client_name)
                 ),' ',
                (select last_name
                 from tab_human_name
                 where tab_human_name.id_human_name=
                       (select id_client_name
                        from tab_clients
                        where tab_clients.id_client = new.id_client_name)
                 ), ' ',
                (select patronymic
                 from tab_human_name
                 where tab_human_name.id_human_name=
                       (select id_client_name
                        from tab_clients
                        where tab_clients.id_client = new.id_client_name)
                 ), ' купил ',
                (select product_name
                 from tab_products_name
                 where id_product_name =
                       (select tab_products.id_product
                        from tab_products
                        where id_product = new.id_product)
                 ), ' производитель ',
                 (select manufacturer
                 from tab_manufacturer
                 where id_manufacturer =
                       (select tab_products.id_manufacturer
                        from tab_products
                        where id_product = new.id_product)
                 ), ' продавец ',
                (select first_name
                 from tab_human_name
                 where tab_human_name.id_human_name=
                       (select id_worker_name
                        from tab_workers
                        where id_worker_name = new.id_worker_name)
                 ),' ',
                (select last_name
                 from tab_human_name
                 where tab_human_name.id_human_name=
                       (select id_worker_name
                        from tab_workers
                        where id_worker_name = new.id_worker_name)
                 ), ' ',
                (select patronymic
                 from tab_human_name
                 where tab_human_name.id_human_name=
                       (select id_worker_name
                        from tab_workers
                        where id_worker_name = new.id_worker_name)
                ))

          );

delimiter ||
create trigger trg_archive_product
  before update on tab_products
  for each row
   begin
    if new.product_quantity=0 then
        begin
            set new.is_delete=true;
            insert into tab_archive_products(id_product, is_delete)
                value ((select new.id_product), false);
        end;
    end if;
end||

delimiter ||
create trigger trg_client_reg_ban
  before insert on tab_clients
  for each row
   begin
    select @is_email:=count(new.email) from tab_clients where new.email=email;
    if @is_email=0 then
        begin
            insert into tab_clients(id_client_name, id_gender, id_subscribe, telephone, email, discount)
                value ((select  new.id_client_name),
                       (select  new.id_gender),
                       (select  new.id_subscribe),
                       (select  new.telephone),
                       (select  new.email),
                       (select  new.discount));
        end;
    end if;
end||




show triggers;
drop trigger trg_sales_insert;
drop trigger trg_archive_product;
delimiter ||
create procedure client_not_del(in id_client_ int)
begin
    update tab_clients
    set is_delete = 0
    where id_client = id_client_;

end ||
-- ---------------------------------------------------------------------------------------------
delimiter ||
create procedure add_client(in first_name_ text,
                            in last_name_ text, in patronymic_ text, in telephone_ varchar(50),
                            in email_ varchar(50), in gender_ text, in subscribe_ text)
begin
if((select count(email) from tab_clients where email = email_) = 0) then


    if (((select count(last_name) from tab_human_name where last_name != last_name_) != 0 or
          (select count(first_name) from tab_human_name where last_name != first_name_) != 0 or
          (select count(patronymic) from tab_human_name where patronymic != patronymic_) != 0) or
        (select count(email) from tab_clients where email = email_) != 0)  then
        insert into tab_human_name (last_name, first_name, patronymic)
            value (last_name_, first_name_, patronymic_);

        if ((select count(gender) from tab_gender where gender = gender_) = 0) then
            insert into tab_gender(gender)
                value (gender_);
        end if;
        if ((select count(subscribe) from tab_subscribe where subscribe = subscribe_) = 0) then
            insert into tab_subscribe(subscribe) value (subscribe_);
        end if;

        insert into tab_clients (id_client_name, id_gender, id_subscribe, telephone, email)
            value ((select id_human_name
                    from tab_human_name
                    where last_name = last_name_
                      and first_name = first_name_
                      and patronymic = patronymic_),
                   (select id_gender from tab_gender where gender = gender_),
                   (select id_subscribe from tab_subscribe where subscribe = subscribe_),
                   telephone_, email_);
    end if;
end if;
end ||
-- ---------------------------------------------------------------------------------------------
delimiter ||
create procedure add_product(
    in product_name_ text ,
    in type_of_product_ text ,
    in manufacturer_ text,
    in product_quantity_ int ,
    in price_ int ,
    in cost_price_ int
    )
    begin
        /*if ((select manufacturer from tab_manufacturer where manufacturer !='Спорт, солнце и штанга')) then
            if ((select id_product_name from tab_products_name where product_name_ = product_name) != 0
                )then


        end if;*/
    end ||
-- ---------------------------------------------------------------------------------------------
  delimiter ||
  create procedure add_worker(
    in id_post_ int ,
    in id_gender_ int  ,
    in id_worker_name_ int  ,
    in date_of_employment_ date ,
    in wages_ int)
      begin
          if ((select count(*) from tab_workers) < 6) then
              insert into tab_workers(id_post, id_gender, id_worker_name, date_of_employment, wages)
                  value (id_post_, id_gender_, id_worker_name_, date_of_employment_, wages_);
          end if;
      end ||
-- ---------------------------------------------------------------------------------------------

call add_client('first 10', 'last 10', 'patronymic 10',
                '+7999999999', 'aaa@aaaa11.ru', 'man', 'sub1');
call add_worker(1, 1, 2, '1999-02-12', 333);
drop procedure client_not_del;
drop procedure add_client;
drop procedure add_worker;

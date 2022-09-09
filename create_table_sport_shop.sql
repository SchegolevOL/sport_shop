CREATE TABLE tab_products_name (
    id_product_name int not null primary key auto_increment,
    product_name text not null,
    is_delete bool default false
);

create table  tab_type_of_products(
    id_type_of_product int not null primary key auto_increment,
    type_of_product text not null,
    is_delete bool default false
);

create table  tab_manufacturer(
    id_manufacturer int not null primary key auto_increment,
    manufacturer text not null,
    is_delete bool default false
);

create table  tab_products(
    id_product int not null primary key auto_increment,
    id_product_name int not null,
    id_type_of_product int not null,
    id_manufacturer int not null,
    product_quantity int not null,
    price int not null,
    cost_price int not null,
    is_delete bool default false,
    foreign key (id_product_name) references tab_products_name(id_product_name)
                            on delete no action
                            on update no action,
    foreign key (id_type_of_product) references tab_type_of_products(id_type_of_product)
                            on delete no action
                            on update no action,
    foreign key (id_manufacturer) references tab_manufacturer(id_manufacturer)
                            on delete no action
                            on update no action
);

create table tab_human_name
(
    id_human_name     int  not null primary key auto_increment,
    last_name  text not null,
    first_name text not null,
    patronymic text,
    is_delete          bool default false
);

create table tab_gender(
    id_gender int  not null primary key auto_increment,
    gender text not null,
    is_delete bool default false
);

create table tab_subscribe(
    id_subscribe int not null primary key auto_increment,
    subscribe text not null,
    is_delete bool default false
);

create table tab_post(
    id_post int not null primary key auto_increment,
    post text not null,
    is_delete bool default false
);

create table tab_workers(
    id_worker int  not null primary key auto_increment,
    id_post int not null,
    id_gender int  not null,
    id_worker_name int  not null,
    date_of_employment date not null,
    wages int not null,
    is_delete bool default false,
    foreign key (id_worker_name) references tab_human_name(id_human_name)
                    on delete no action
                    on update no action,
    foreign key (id_post) references tab_post(id_post)
                    on delete no action
                    on update no action,
    foreign key (id_gender) references tab_gender(id_gender)
                    on delete no action
                    on update no action
);

create table tab_clients(
    id_client int not null primary key auto_increment,
    id_client_name int  not null ,
    id_gender int  not null,
    id_subscribe int not null ,
    telephone varchar(50) not null ,
    email varchar(50) not null,
    discount int not null default 0,
    is_delete bool default false,
    foreign key (id_client_name) references tab_human_name(id_human_name)
                    on delete no action
                    on update no action,
    foreign key (id_gender) references tab_gender(id_gender)
                    on delete no action
                    on update no action,
    foreign key (id_subscribe) references tab_subscribe(id_subscribe)
                    on delete no action
                    on update no action
);

create table tab_sales(
    id_sales int not null primary key auto_increment,
    id_product int not null,
    sale_price int not null,
    quantity int not null,
    date_of_sale date not null,
    id_client_name int  not null,
    id_worker_name int  not null,
    is_delete bool default false,
    foreign key (id_product) references tab_products(id_product)
                    on delete no action
                    on update no action,
    foreign key (id_client_name) references tab_clients(id_client)
                    on delete no action
                    on update no action,
    foreign key (id_worker_name) references  tab_workers(id_worker)
                    on delete no action
                    on update no action
);

create table tab_history_sales(
    id_history_sales int not null  primary key auto_increment,
    date_sales datetime not null default now(),
    event_type_long_id int not null,
    massage text null,
    is_delete bool default false,
    foreign key (event_type_long_id) references tab_event_types(event_type_log_id)
                            on delete no action
                            on update no action
);

create table tab_event_types(
    event_type_log_id int not null primary key auto_increment,
    event_type_name text not null
);

create table tab_archive_products(
    id_archive_product int not null  primary key auto_increment,
    id_product int not null,
    is_delete bool default false
);

create table tab_last_unit_products(
    id_last_unit_products int not null primary key auto_increment,
    id_product int,
    is_delete bool default false
)
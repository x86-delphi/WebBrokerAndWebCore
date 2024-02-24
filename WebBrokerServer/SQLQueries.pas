unit SQLQueries;

interface

ResourceString
  Customers_Insert = 'insert into customers(id, firstname, lastname, country) values(:id, :firstname, :lastname, :country)';
  Customers_Update = 'update customers set firstname = :firstname, lastname = :lastname, country = :country where id = :id';
  Customers_Delete = 'delete from customers where id = :id';
  Customers_Select = 'select * from customers';
  Customers_Select2 = 'select * from customers where id = :id';

implementation

end.
